require 'spec_feature_helper'

describe 'cookbook following' do
  it 'allows a user to follow a cookbook' do
    cookbook = create(:cookbook)

    visit cookbook_path(cookbook)
    follow_relation('follow')

    expect(page).to have_selector('.following')
  end
end
