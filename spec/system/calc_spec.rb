RSpec.describe 'calc receipt', type: :feature do
  before(:each) do
    visit('/')
    click_on('Calc receipt for last month')
  end

  it 'calc no limit' do
    fill_in('phone', with: '123456')
    fill_in('minutes', with: '5')
    click_on('Calc')
    expect(page).to have_content('You have to paid 420')
  end

  it 'calc combined into packet' do
    fill_in('phone', with: '123457')
    fill_in('minutes', with: '5')
    click_on('Calc')
    expect(page).to have_content('You have to paid 300')
  end

  it 'calc combined out packet' do
    fill_in('phone', with: '123457')
    fill_in('minutes', with: '400')
    click_on('Calc')
    expect(page).to have_content('You have to paid 317.0')
  end

  it 'calc no limit' do
    fill_in('phone', with: '123459')
    fill_in('minutes', with: '100')
    click_on('Calc')
    expect(page).to have_content('You have to paid 218.0')
  end
end
