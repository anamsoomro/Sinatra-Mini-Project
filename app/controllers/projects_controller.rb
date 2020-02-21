class ProjectsController < ApplicationController
  set :views, "app/views/projects"

  get "/projects" do 
    @projects = Project.all
    erb :index
  end

  get "/projects/new" do 
    erb :new
  end

  get "/projects/:id" do 
    @project = current_project
    erb :show
  end

  get "/projects/:id/edit" do 
    @project = current_project
    erb :edit
  end

  post "/projects" do
    Project.create(name: params[:project][:name])
    redirect "/projects"
  end

  patch "/projects/:id" do 
    @project = current_project
    @project.update(name: params[:project][:name])
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
