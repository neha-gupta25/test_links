class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params_for_page)
    @page.html = params[:page][:html].open.read if params[:page][:html].present?
    if @page.save
      flash[:notice] = 'Page successfully created'
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def show
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy!
    flash[:notice] = 'Successfully deleted'
    redirect_to action: :index
  end

  def ppc
    @page = Page.find(params[:id])
    tags = Nokogiri::HTML.parse(@page.html)
    ppc_link_breakup(tags)
  end

  def organic
    @page = Page.find(params[:id])
    tags = Nokogiri::HTML.parse(@page.html)
    organic_link_breakup(tags)
  end

  private

  def params_for_page
    params.require(:page).permit(:html,:name)
  end

  def ppc_link_breakup(tags)
    @ppcs = tags.css("li.ads-ad h3 a")
    @ppcs = @ppcs.map { |link|  link}
    @ppcs = @ppcs - @ppcs.map { |link|  link if %w{display:none}.include?link['style'] }
  end

  def organic_link_breakup(tags)
    @organics = tags.css(".med h3 a")
    @organics = @organics.map { |link|  link}
    @organics = @organics - @organics.map { |link|  link if %w{display:none}.include?link['style'] }
  end

end
