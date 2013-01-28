require 'spec_helper'

describe DishesController do
  def valid_attributes
    { "name" => "dish",
      "price" => 15.5,
      "category_id" => 1,
      "cover" => "cover",
      "content" => "content"
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all dishes as @dishes" do
      dish = Dish.create! valid_attributes
      get :index, {}, valid_session
      assigns(:dishes).should eq([dish])
    end
  end

  describe "GET show" do
    it "assigns the requested dish as @dish" do
      dish = Dish.create! valid_attributes
      get :show, {:id => dish.to_param}, valid_session
      assigns(:dish).should eq(dish)
    end
  end

  describe "GET new" do
    it "assigns a new dish as @dish" do
      get :new, {}, valid_session
      assigns(:dish).should be_a_new(Dish)
    end
  end

  describe "GET edit" do
    it "assigns the requested dish as @dish" do
      dish = Dish.create! valid_attributes
      get :edit, {:id => dish.to_param}, valid_session
      assigns(:dish).should eq(dish)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Dish" do
        expect {
          post :create, {:dish => valid_attributes}, valid_session
        }.to change(Dish, :count).by(1)
      end

      it "assigns a newly created dish as @dish" do
        post :create, {:dish => valid_attributes}, valid_session
        assigns(:dish).should be_a(Dish)
        assigns(:dish).should be_persisted
      end

      it "redirects to the created dish" do
        post :create, {:dish => valid_attributes}, valid_session
        response.should redirect_to(Dish.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved dish as @dish" do
        # Trigger the behavior that occurs when invalid params are submitted
        Dish.any_instance.stub(:save).and_return(false)
        post :create, {:dish => { "name" => "invalid value" }}, valid_session
        assigns(:dish).should be_a_new(Dish)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Dish.any_instance.stub(:save).and_return(false)
        post :create, {:dish => { "name" => "invalid value" }}, valid_session
        response.should render_template(I18n.t('dishes.edit.title'))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested dish" do
        dish = Dish.create! valid_attributes
        # Assuming there are no other dishes in the database, this
        # specifies that the Dish created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Dish.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => dish.to_param, :dish => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested dish as @dish" do
        dish = Dish.create! valid_attributes
        put :update, {:id => dish.to_param, :dish => valid_attributes}, valid_session
        assigns(:dish).should eq(dish)
      end

      it "redirects to the dish" do
        dish = Dish.create! valid_attributes
        put :update, {:id => dish.to_param, :dish => valid_attributes}, valid_session
        response.should redirect_to(dish)
      end
    end

    describe "with invalid params" do
      it "assigns the dish as @dish" do
        dish = Dish.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Dish.any_instance.stub(:save).and_return(false)
        put :update, {:id => dish.to_param, :dish => { "name" => "invalid value" }}, valid_session
        assigns(:dish).should eq(dish)
      end

      it "re-renders the 'edit' template" do
        dish = Dish.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Dish.any_instance.stub(:save).and_return(false)
        put :update, {:id => dish.to_param, :dish => { "name" => "invalid value" }}, valid_session
        response.should render_template(I18n.t('dishes.edit.title'))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested dish" do
      dish = Dish.create! valid_attributes
      expect {
        delete :destroy, {:id => dish.to_param}, valid_session
      }.to change(Dish, :count).by(-1)
    end

    it "redirects to the dishes list" do
      dish = Dish.create! valid_attributes
      delete :destroy, {:id => dish.to_param}, valid_session
      response.should redirect_to(dishes_url)
    end
  end

end
