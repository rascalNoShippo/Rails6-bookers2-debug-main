class SearchesController < ApplicationController
  
  def search
    @lists = looks(params[:search_method], params[:query])
  end
  
  def looks(search_method, query) 
    list = {"Book" => [Book.all, "title", "body"], "User" => [User.all, "name", "introduction"]}
    model = list[params[:model]][0]
    @col_1 = list[params[:model]][1]
    @col_2 = list[params[:model]][2]
    
    if search_method == "perfect"
      model.where("#{@col_1} like ?", "#{query}").or(model.where("#{@col_2} like ?", "#{query}"))
    elsif search_method == "forward"
      model.where("#{@col_1} like ?", "#{query}%").or(model.where("#{@col_2} like ?", "#{query}%"))
    elsif search_method == "backward"
      model.where("#{@col_1} like ?", "%#{query}").or(model.where("#{@col_2} like ?", "%#{query}"))
    elsif search_method == "partial"
      model.where("#{@col_1} like ?", "%#{query}%").or(model.where("#{@col_2} like ?", "%#{query}%"))
    else
      model
    end
  end
  
end
