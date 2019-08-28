# frozen_string_literal: true

class PagesController < ApplicationController
  def top
    @rooms = Room.where(active: true).limit(3)
  end

  def search

  end
end
