require 'spec_helper'

describe CategoriesController do
  #def valid_attributes
    #{ "name" => "drink" }
  #end

  #def valid_session
    #{}
  #end

  #describe "should be redirect when no one is signed in" do
    #it "Get index" do
      #get 'index'
      #response.should be_redirect
      #response.should redirect_to(root_path)
    #end

    #it "Get 'new'" do
      #get 'new'
      #response.should be_redirect
      #response.should redirect_to(root_path)
    #end

    #it "Get edit" do
      #category = Category.create! valid_attributes
      #get :edit, {:id => category.to_param}, valid_session
      #response.should be_redirect
      #response.should redirect_to(root_path)
    #end

    #it "Get show" do
      #category = Category.create! valid_attributes
      #get :show, {:id => category.to_param}, valid_session
      #response.should be_redirect
      #response.should redirect_to(root_path)
    #end
  #end

  #describe "GET index" do
    #it "renders the category list when admin" do
      #login_admin
      #get 'index'
      #response.should render_template('index')
    #end
  #end

  #describe "GET show" do
    #it "assigns the requested category as @category" do
      #login_admin
      #category = Category.create! valid_attributes
      #get :show, {:id => category.to_param}, valid_session
      #assigns(:category).should eq(category)
    #end
  #end

  #describe "GET new" do
    #it "assigns a new category as @category" do
      #login_admin
      #get :new, {}, valid_session
      #assigns(:category).should be_a_new(Category)
        #assigns[:category].should be_a_new_record
    #end
  #end

  #describe "GET edit" do
    #it "assigns the requested category as @category" do
      #login_admin
      #category = Category.create! valid_attributes
      #get :edit, {:id => category.to_param}, valid_session
      #assigns(:category).should eq(category)
    #end
  #end

  #describe "POST create" do
    #describe "with valid params" do
      #login_admin
      #it "creates a new Category" do
        #expect {
          #post :create, {:category => valid_attributes}, valid_session
        #}.to change(Category, :count).by(1)
      #end

      #it "assigns a newly created category as @category" do
        #post :create, {:category => valid_attributes}, valid_session
        #assigns(:category).should be_a(Category)
        #assigns(:category).should be_persisted
      #end

      #it "redirects to the created category" do
        #post :create, {:category => valid_attributes}, valid_session
        #response.should redirect_to(Category.last)
      #end
    #end

    #describe "with invalid params" do
      #login_admin
      #it "assigns a newly created but unsaved category as @category" do
        ## Trigger the behavior that occurs when invalid params are submitted
        #Category.any_instance.stub(:save).and_return(false)
        #post :create, {:category => { "name" => "invalid value" }}, valid_session
        #assigns(:category).should be_a_new(Category)
      #end

      #it "re-renders the 'new' template" do
        ## Trigger the behavior that occurs when invalid params are submitted
        #Category.any_instance.stub(:save).and_return(false)
        #post :create, {:category => { "name" => "invalid value" }}, valid_session
        #response.should render_template(I18n.t('categories.new.title'))
      #end
    #end
  #end

  #describe "PUT update" do
    #describe "with valid params" do
      #login_admin
      #it "updates the requested category" do
        #category = Category.create! valid_attributes
        ## Assuming there are no other categories in the database, this
        ## specifies that the Category created on the previous line
        ## receives the :update_attributes message with whatever params are
        ## submitted in the request.
        #Category.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        #put :update, {:id => category.to_param, :category => { "name" => "MyString" }}, valid_session
      #end

      #it "assigns the requested category as @category" do
        #category = Category.create! valid_attributes
        #put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        #assigns(:category).should eq(category)
      #end

      #it "redirects to the category" do
        #category = Category.create! valid_attributes
        #put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        #response.should redirect_to(category)
      #end
    #end

    #describe "with invalid params" do
      #login_admin
      #it "assigns the category as @category" do
        #category = Category.create! valid_attributes
        ## Trigger the behavior that occurs when invalid params are submitted
        #Category.any_instance.stub(:save).and_return(false)
        #put :update, {:id => category.to_param, :category => { "name" => "invalid value" }}, valid_session
        #assigns(:category).should eq(category)
      #end

      #it "re-renders the 'edit' template" do
        #category = Category.create! valid_attributes
        ## Trigger the behavior that occurs when invalid params are submitted
        #Category.any_instance.stub(:save).and_return(false)
        #put :update, {:id => category.to_param, :category => { "name" => "invalid value" }}, valid_session
        #response.should render_template(I18n.t('categories.edit.title'))
      #end
    #end
  #end

  #describe "DELETE destroy" do
    #login_admin
    #it "destroys the requested category" do
      #category = Category.create! valid_attributes
      #expect {
        #delete :destroy, {:id => category.to_param}, valid_session
      #}.to change(Category, :count).by(-1)
    #end

    #it "redirects to the categories list" do
      #category = Category.create! valid_attributes
      #delete :destroy, {:id => category.to_param}, valid_session
      #response.should redirect_to(categories_url)
    #end
  #end

end
