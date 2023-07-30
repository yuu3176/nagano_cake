class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @total = 0
  end
end
