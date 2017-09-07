require 'rails_helper'

RSpec.feature "Coupon management" do
  scenario "wat" do
    visit '/payful'

    click_on "coupons-section"
    click_on "new-coupon"

    fill_in :coupon_code,        with: "coupon-code"
    fill_in :coupon_description, with: "coupon-description"
    fill_in :coupon_redemption_limit, with: "2"
    select "discount", from: :coupon_coupon_type
    fill_in :coupon_amount,      with: "100"
    fill_in :coupon_valid_from,  with: "1987/04/21"
    fill_in :coupon_valid_until, with: "2017/04/21"

    click_button 'save'

    coupon = Payful::Coupon.last
    expect(coupon.code).to                eq "coupon-code"
    expect(coupon.description).to         eq "coupon-description"
    expect(coupon.valid_from.iso8601).to  eq "1987-04-21T00:00:00Z"
    expect(coupon.valid_until.iso8601).to eq "2017-04-21T00:00:00Z"
    expect(coupon.redemption_limit).to    eq 2
    expect(coupon.amount).to              eq 100
    expect(coupon.coupon_type).to         eq "discount"

    expect(current_path).to eq payful.coupons_path
    expect(page).to have_content I18n.t("views.forms.saved")
    expect(page).to have_content "coupon-code"
    expect(page).to have_content "coupon-description"
  end
end
