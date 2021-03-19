class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name , :grade
  attr_reader :id
  
  def initialize(name, grade, id = nil)
    @name = name 
    @grade = grade 
    @id = id 
  end 
  
  def self.create_table 
    sql = <<-q 
    CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARy KEY,
    name TEXT,
    grade INTEGER)
    q
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table 
    sql = <<-q 
    DROP TABLE students
    q
   DB[:conn].execute(sql) 
  end 
  
 def save
    quote = <<-q 
    INSERT INTO students (name, grade) VALUES (?,?) 
    q
    
    DB[:conn].execute(quote, self.name , self.grade)
    
    @id = DB[:conn].execute("SELECT id FROM students order by id desc limit 1 ")[0][0]
  end 
  
  def self.create(name:, grade:)
    what = Student.new(name, grade)
    what.save 
    what 
  end 
  
  
  
  
  
end 