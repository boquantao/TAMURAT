require 'rails_helper'

RSpec.describe Company, type: :model do
    
    describe "ActiveRecord test" do
       it { should have_many(:answers).with_foreign_key(:company_id).dependent(:destroy) } 
       it { should have_many(:subcategory_scores).with_foreign_key(:company_id).dependent(:destroy) } 
       it { should have_many(:category_scores).with_foreign_key(:company_id).dependent(:destroy) } 
       it { should have_many(:scenario_weights).with_foreign_key('company_id').dependent(:destroy) } 
       it { should have_many(:scenarios)} 
       it { should have_many(:children).with_foreign_key('parent_id').dependent(:destroy) }
       
       it { should belong_to(:user).with_foreign_key(:user_id) } 
       it { should belong_to(:parent).optional } 
    end    

    describe "presence validation" do
        it { is_expected.to validate_presence_of :user_id }
        it { is_expected.to_not validate_absence_of :user_id }
    end

    describe "uniqueness validation" do
        it 'should not have two companies with the same user_id' do
            @validator = create(:validator)
            @company = create(:company, user_id:  @validator.id)        
            CP1 = Company.new(user_id: @validator.id ,weight_sum: 5,score: 4)
            expect(CP1).not_to be_valid 
        end
    end
end