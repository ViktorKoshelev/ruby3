RSpec.describe 'show subscribers', type: :feature do
  it 'all subscribers' do
    visit('/')
    click_on('All')
    expect(page).to have_content('first user, tarif: 1, num: 123456')
    expect(page).to have_content('second user, tarif: 2, num: 123457')
    expect(page).to have_content('third user, tarif: 2, num: 123458')
    expect(page).to have_content('fourth user, tarif: 3, num: 123459')
  end

  it 'no limits' do
    visit('/')
    click_on('No limit')
    expect(page).to have_content('first user, tarif: 1, num: 123456')
  end

  it 'combined' do
    visit('/')
    click_on('Combined')
    expect(page).to have_content('second user, tarif: 2, num: 123457')
    expect(page).to have_content('third user, tarif: 2, num: 123458')
  end

  it 'by time' do
    visit('/')
    click_on('By time')
    expect(page).to have_content('fourth user, tarif: 3, num: 123459')
  end
end
