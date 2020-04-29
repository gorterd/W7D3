require 'rails_helper'

RSpec.describe UsersController, type: :controller do 

    describe "get #show" do
        it "should render the show template" do
            allow(subject).to receive(:logged_in?).and_return true
            create :user
            get :show, params: { id: User.last.id }
            expect(response).to render_template(:show)
        end
    end

    describe "get #new" do
        it "should render the new template" do 
            get :new
            expect(response).to render_template("new")
        end
    end


    describe "post #create" do

        context "when valid params" do
            it "should redirect to user page (#show)" do
                post :create, params: { user: { username: 'modelo', password: 'ilovebeer' } }

                expect(response).to redirect_to(user_url(User.last.id))
            end
        end

        context "when invalid params" do
            it "should render :new template" do 
                post :create, params: { user: { password: 'ilovebeer' } }
                expect(response).to render_template(:new)
            end
            
            it "should return an error message when missing paramter" do 
                post :create, params: { user: { password: 'ilovebeer' } }
                expect(flash[:errors]).to be_present
            end
            
            it "should return an error message when password too short" do
                post :create, params: { user: { username: 'darth_vader', password: 'ilov' } }
                expect(flash[:errors]).to be_present
            end
        end
    end
end