class StudentsController < ApplicationController
  set :views, "app/views/students"

  #display list of students
  get '/students' do 
    @students = Student.all 
    erb :index 
  end
  #create a new form for student
  get '/students/new' do 
    erb :new
  end
  #shows the form of a student
  get '/students/:id' do 
    @student = current_student
    erb :show 
  end
  #creates a new student
  post '/students' do 
    student = Student.create(params)
    redirect "/students/#{student.id}"
  end
  #creates a edit form for student
  get '/students/:id/edit' do 
    @student = current_student
    erb :edit
  end
  #updates student 
  patch '/students/:id' do 
    student = current_student
    student.update(name: params[:name])
    redirect "/students/#{student.id}"
  end
  delete '/students/:id' do 
    student = current_student
    student.destroy
    redirect '/students'
  end


  def current_student
    # binding.pry
    Student.find(params[:id])
  end

end