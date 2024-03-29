require 'spec_helper'

describe UsersController do

  describe "Users Pages" do
    subject { page }

    describe "signup page" do
      before { visit signup_path }
      it { should have_selector('h1',    text: 'Sign up') }
      it { should have_selector('title', text: full_title('Sign up')) } 
    end

    describe "signup" do

      before { visit signup_path }

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end
      end
    end  

    describe "index" do

      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
        visit users_path
      end

      it { should have_selector('title', text: 'All users') }
      it { should have_selector('h1',    text: 'All users') }

      describe "delete links" do

        it { should_not have_link('delete') }

        describe "as an admin user" do
          let(:admin) { FactoryGirl.create(:admin) }
          before do
            sign_in admin
            visit users_path
          end

          it { should have_link('delete', href: user_path(User.first)) }
          it "should be able to delete another user" do
            expect { click_link('delete') }.to change(User, :count).by(-1)
          end
          it { should_not have_link('delete', href: user_path(admin)) }
        end
      end
    end

    describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
      let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

      before { visit user_path(user) }

      it { should have_selector('h1',    text: user.name) }
      it { should have_selector('title', text: user.name) }

      describe "microposts" do
        it { should have_content(m1.content) }
        it { should have_content(m2.content) }
        it { should have_content(user.microposts.count) }
      end
    end

  end

end
