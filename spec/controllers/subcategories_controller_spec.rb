require 'rails_helper'

RSpec.describe SubcategoriesController, type: :controller do
    
    before :each do
        @category = create(:category)
        @subcategory = create(:sub, category_id: @category.id )
    end       
    
    describe "not login" do
        describe "SubcategoriesController#index" do
            it 'should redirect to the page of login' do
                get :index
                expect(response).to redirect_to login_url
            end             
        end    
    
        describe "SubcategoriesController#show" do
            it 'should redirect to the page of login' do
                get :show, params: { id: @subcategory.id }
                expect(response).to redirect_to login_url
            end             
        end         
        
        describe "SubcategoriesController#update" do
            it 'should redirect to the page of login' do
                put :update, params: { :id => @subcategory.id, :subcategory => attributes_for(:sub)   }
                expect(response).to redirect_to login_url
            end             
        end          
    
    end
    
    describe " not admin/decision_maker" do
        
        before :each do
            @representative = create(:representative)
            session[:user_id] = @representative.id        
        end        
        
        describe "SubcategoriesController#index" do
            it 'should redirect to the root page' do
                get :index
                expect(response).to redirect_to root_url
            end             
        end    
    
        describe "SubcategoriesController#show" do
            it 'should redirect to the root page' do
                get :show, params: { id: @subcategory.id }
                expect(response).to redirect_to root_url
            end             
        end 
    end
    
    describe "login as admin or decision_maker" do
        
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id
        end
        describe "SubcategoriesController#index" do
            it 'should redirect to questions_url' do
                get :index
                expect(response).to redirect_to questions_url
            end             
        end    
    
        describe "SubcategoriesController#show" do
            it 'should redirect to questions_url' do
                get :show, params: { id: @subcategory.id }
                expect(response).to redirect_to questions_url
            end             
        end 
        
        describe "SubcategoriesController#update" do
            it 'update successfully and redirect to questions_url' do
                attr = attributes_for(:sub)
                attr[:category_id] = @category.id
                put :update, params: { :id => @subcategory.id, :subcategory => attr   }
                
                expect(flash[:success]).to match("#{@subcategory.name} was successfully updated.")
                expect(response).to redirect_to questions_url
            end       
            
            it 'update failed and redirect to edit_subcategory_url' do
                attr = attributes_for(:sub)
                attr[:category_id] = @category.id
                attr[:weight] = 'a'
                put :update, params: { :id => @subcategory.id, :subcategory => attr   }
                
                expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
                expect(response).to redirect_to edit_subcategory_url(@subcategory.id)
            end               
        end  
        
        describe "SubcategoriesController#create" do
            it 'create successfully and redirect to new_subcategory_url' do
                attr = attributes_for(:sub)
                attr[:category_id] = @category.id
                attr[:weight] = 'a'
                post :create, params: {:subcategory => attr }
                
                expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
                expect(response).to redirect_to new_subcategory_url
            end          
            
            it 'update failed and redirect to questions_url' do
                attr = attributes_for(:sub)
                attr[:category_id] = @category.id
                post :create, params: {:subcategory => attr }
                
                expect(flash[:success]).to match("#{@subcategory.name} was successfully created.")
                expect(response).to redirect_to questions_url
            end               
        end  
        
       
        describe "SubcategoriesController#new" do

            it "collects category into @category" do
                @category = create(:category)
                @subcategory_new = Subcategory.new
                get :new,params:{:category_id => @category.id}
                expect(assigns(@subcategory.name)).to eq(@subcategory_new.name)
            end        
            
            it 'should render new' do
                get :new,params:{:category_id => @category.id}
                expect(response).to render_template('new')
            end             
        end        
    
   
        describe "SubcategoriesController#edit" do
            it 'render edit' do
                get :edit, params: { id: @subcategory.id }
                expect(response).to render_template('edit')
            end             
        end      
       
        describe "SubcategoriesController#destroy" do
            
            it 'should redirect to questions_url' do
                delete :destroy,params: { id: @subcategory.id }
                
                expect(flash[:success]).to match("Subcategory '#{@subcategory.name}' deleted.")
                expect(response).to redirect_to questions_url
            end          
            
              
        end     
        
    end
end
