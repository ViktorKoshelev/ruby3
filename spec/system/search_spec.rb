RSpec.describe 'find subscribers', type: :feature do
  it 'find_by_name' do
    visit('/')
    click_on('By name')
    fill_in('name', with: 'first user')
    click_on('Find subscribers')
    expect(page).to have_content('first user, tarif: 1, num: 123456')
  end

  it 'find_by_phone' do
    visit('/')
    click_on('By phone')
    fill_in('phone', with: '123456')
    click_on('Find subscribers')
    expect(page).to have_content('first user, tarif: 1, num: 123456')
  end
end
