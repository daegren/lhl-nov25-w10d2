# frozen_string_literal: true

require 'rails_helper'
require 'support/database_cleaner'

RSpec.feature 'Bicycle index', type: :feature, js: true do
  before :each do
    @bike1 = FactoryBot.create(:bicycle,
                               brand: FactoryBot.create(:brand, name: 'Brand', country: 'Canada'),
                               style: FactoryBot.create(:style, name: 'Fixie'),
                               speeds: 1,
                               colour: 'Red',
                               model: 'Moustache')
    @bike2 = FactoryBot.create(:bicycle,
                               brand: FactoryBot.create(:brand, name: 'Hildebrand', country: 'USA'),
                               style: FactoryBot.create(:style, name: 'Hybrid'),
                               speeds: 10,
                               colour: 'Black',
                               model: 'Roadmeister')
  end

  scenario 'Lists all bikes' do
    visit '/bicycles'

    save_screenshot('all_bikes.png')
    expect(page).to have_css('.bicycle', count: 2)
    expect(page).to have_text('Red Brand Moustache Fixie', count: 1)
    expect(page).to have_text('Black 10-speed Hildebrand Roadmeister Hybrid', count: 1)
  end

  scenario 'filter by model' do
    visit bicycles_path

    fill_in 'Model', with: 'Moustache'
    click_on 'Search!'

    save_screenshot('filter_model.png')

    expect(page).to have_css('.bicycle', count: 1)
    expect(page).to have_text('Red Brand Moustache Fixie', count: 1)
    expect(page).to have_text('Black 10-speed Hildebrand Roadmeister Hybrid', count: 0)
  end

  scenario 'filter by style' do
    visit bicycles_path

    select 'Hybrid', from: 'Style'
    click_on 'Search!'
    
    save_screenshot('filter_style.png')
    expect(page).to have_css('.bicycle', count: 1)
    expect(page).to have_text('Red Brand Moustache Fixie', count: 0)
    expect(page).to have_text('Black 10-speed Hildebrand Roadmeister Hybrid', count: 1)
  end
  
  scenario 'filter by brand' do
    visit bicycles_path
    
    select 'Brand', from: 'Brand'
    click_on 'Search!'
    expect(page).to have_css('.bicycle', count: 1)
    expect(page).to have_text('Red Brand Moustache Fixie', count: 1)
    expect(page).to have_text('Black 10-speed Hildebrand Roadmeister Hybrid', count: 0)
  end
  
  scenario 'filter by speeds' do
    visit bicycles_path

    fill_in 'Speeds', with: 10
    click_on 'Search!'
    expect(page).to have_css('.bicycle', count: 1)
    expect(page).to have_text('Red Brand Moustache Fixie', count: 0)
    expect(page).to have_text('Black 10-speed Hildebrand Roadmeister Hybrid', count: 1)
  end

  scenario 'temp' do
    visit 'http://google.com'

    save_screenshot('temp.png')
  end
end
