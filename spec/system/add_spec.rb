RSpec.describe 'add subscriber', type: :feature do
  it 'new' do
    visit('/')
    click_on('Add subscriber')
    expect(page).to have_content('Add new subscriber')

    fill_in('first', with: 'one')
    fill_in('last', with: 'more')
    fill_in('tarif', with: '3')

    click_on('Add')
    expect(page).to have_content('User added')
    expect(page).to have_content('one more, tarif: 3, num: 100000')
  end

  after do
    visit('/')
    click_on('Delete subscriber')

    fill_in('name', with: 'one more')

    click_on('Delete subscribers')
  end
end
