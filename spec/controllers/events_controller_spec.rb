require 'spec_helper'

describe EventsController do
  def valid_attributes
    { "title"      => "huodong",
      "start_date" => "2012-9-12",
      "end_date"   => "2013-3-1"
    }
  end

  def valid_session
    {}
  end

  describe "GET 'index'" do
    it "renders the event list" do
      get 'index'
      response.should render_template('index')
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :show, {:id => event.to_param}, valid_session
      assigns(:event).should eq(event)
    end
  end

  describe "GET 'new'" do
    context 'when user is admin' do
      login_admin
      it "builds a new event" do
        get 'new'
        assigns[:event].should be_a_kind_of(Event)
        assigns[:event].should be_a_new_record
      end

      it "renders the new event form" do
        get 'new'
        response.should render_template('new')
      end
    end

    context 'when user is customer' do
      login_customer
      it "should be redirect" do
        get 'new'
        response.should be_redirect
        response.should redirect_to(root_path)
      end
    end

    context 'when user has not yet signed in' do
      it "should be redirect" do
        get 'new'
        response.should redirect_to(root_path)
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :edit, {:id => event.to_param}, valid_session
      assigns(:event).should eq(event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}, valid_session
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, {:event => valid_attributes}, valid_session
        assigns(:event).should be_a(Event)
        assigns(:event).should be_persisted
      end

      it "redirects to the created event" do
        post :create, {:event => valid_attributes}, valid_session
        response.should redirect_to(Event.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => { "title" => "invalid value" }}, valid_session
        assigns(:event).should be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, {:event => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event" do
        event = Event.create! valid_attributes
        # Assuming there are no other events in the database, this
        # specifies that the Event created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Event.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => event.to_param, :event => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
        assigns(:event).should eq(event)
      end

      it "redirects to the event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
        response.should redirect_to(event)
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => { "title" => "invalid value" }}, valid_session
        assigns(:event).should eq(event)
      end

      it "re-renders the 'edit' template" do
        event = Event.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => event.to_param, :event => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete :destroy, {:id => event.to_param}, valid_session
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete :destroy, {:id => event.to_param}, valid_session
      response.should redirect_to(events_url)
    end
  end

end
