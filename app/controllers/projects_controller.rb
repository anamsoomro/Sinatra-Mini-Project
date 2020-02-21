class ProjectsController < ApplicationController
  set :views, "app/views/projects"

  get "/projects" do 
    @projects = Project.all
    erb :index
  end

  get "/projects/new" do 
    @students=Student.all
    erb :new
  end

  get "/projects/:id" do 
    @project = current_project
    @students = @project.students
    erb :show
  end

  get "/projects/:id/edit" do 
    @project = current_project
    @assigned_students = @project.students
    @students = Student.all
    erb :edit
  end

  post "/projects" do
    new_project = Project.create(name: params[:project][:name])
    params[:student][:student_id].each do |student_id|
      StudentProject.create(student_id: student_id, project_id: new_project.id)
    end
    redirect "/projects"
  end

  patch "/projects/:id" do 
    @project = current_project
    @project.update(name: params[:project][:name])
    @project.student_projects.destroy_all 
    params[:student][:student_id].each do |student_id|
      StudentProject.find_or_create_by(student_id: student_id, project_id: @project.id)
    end
    redirect "/projects/#{@project.id}"
  end

  delete "/projects/:id/delete" do 
    @project = current_project
    @project.destroy

    redirect "/projects"
  end

  def current_project
    Project.find(params[:id])
  end

end
