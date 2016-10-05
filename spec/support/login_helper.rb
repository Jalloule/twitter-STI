module LoginHelper

  def login(user=nil)
    sign_in(user || FactoryGirl.create(:user))
  end

end