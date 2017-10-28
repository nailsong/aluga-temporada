require 'rails_helper'

feature 'visitor visits homepage' do
  scenario 'successfully' do
    visit root_path

    site_description = 'O melhor site para aludar imóveis da internet'
    expect(page).to have_css('h1', text: 'Aluga temporada')
    expect(page).to have_css('p.lead', text: site_description)
  end

  scenario 'and sees a property' do
    property = create(:property)

    visit root_path

    expect(page).to have_css('h2', text: 'Imóveis:')
    expect(page).to have_css('h3', text: 'Casa de frente pro mar')
    expect(page).to have_css('dt', text: 'Tipo da propriedade:')
    expect(page).to have_css('dt', text: 'Localidade:')
    expect(page).to have_css('dt', text: 'Descrição:')
    expect(page).to have_css('dt', text: 'Área:')
    expect(page).to have_css('dt', text: 'Preço da diaria:')

    expect(page).to have_css('dd', text: 'Casa na praia')
    expect(page).to have_css('dd', text: 'Santos, São Paulo')
    expect(page).to have_css('dd', text: 'É uma casa na praia muito cara')
    expect(page).to have_css('dd', text: '150m2')
    expect(page).to have_css('dd', text: 'R$ 200,00')
  end

  scenario 'and there is no properties' do
    visit root_path

    expect(page).to have_css('p', text: 'Nenhum imóvel encontrado')
  end

  scenario 'and clicks on a property' do
    property = create(:property, title: 'Casa na praia')

    visit root_path
    click_on 'Casa na praia'

    expect(current_path).to eq(propert_path(property))
  end
end
