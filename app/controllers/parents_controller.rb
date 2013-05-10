class ParentsController < ApplicationController
  # after_filter :log_action, :only [:create]

  def new
    puts "new action blah"
  	@parent = Parent.new
    @parent.phones.build
    @parent.children.build
    @csz ||= ''
    
  	@method = params[:method] ? params[:method] : -1
    	if ( @method == -1 )
      flash[:error] = "Unrecognized action"
    end
    
  end

  def create
  	@method = params[:parent][:reg_method].to_i
    if @method == Parent::FROM_KIOSK
      params[:parent][:tour_date] = DateTime.current
      params[:parent][:confirmed_status] = Parent::CONFIRM_PENDING
    end
    if @method == Parent::FROM_PHONE
      @csz = params[:parent][:csz].split(/,[\s+]?/)
      if @csz.count == 3
        params[:parent][:city] = @csz[0]
        params[:parent][:state] = @csz[1]
        params[:parent][:zip] = @csz[2]
      end
      
      date = parse_date(params[:parent], "tour_date")
      params[:parent][:tour_date] = date.nil? ? "blank date" : date
    end

    @parent = Parent.new(user_params(@method))
    if @parent.save
      case @method
      when Parent::FROM_KIOSK
        redirect_to root_path
      when Parent::FROM_PHONE
        redirect_to manage_path
      end
    else
      @csz = params[:parent][:csz]
      render :new, :locals => { csz: @csz }
    end
  end

  def update
    @parent = Parent.find_by(params[:id])
    if @parent.update_attributes(edit_params)
      if (params[:delegation_id])
        d = Delegation.find_by(params[:delegation_id])
        d.status = true
        d.save
      end
      redirect_to manage_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end


  def parse_date(params, attrib)
    yr = params["#{attrib}(1i)"].to_i
    mth = params["#{attrib}(2i)"].to_i
    day = (params["#{attrib}(3i)"] || 0).to_i
    hr =  (params["#{attrib}(4i)"] || 0).to_i
    min =  (params["#{attrib}(5i)"] || 0).to_i
    yr = yr == 0 ? Time.now.year : yr
    day = day == 0 ? 1 : day;
    hr = hr == 0 ? Time.now.hour : hr;
    begin
      date = DateTime.new(yr, mth, day, hr, min)
    rescue
      date = nil
    end
    return date
  end

  private
  	def user_params(method)
      case method
      when Parent::FROM_KIOSK
        params.require(:parent).permit( :first_name, :last_name, :addr, :city, :state, :zip,
          :reg_method, :email, :tour_date, :confirmed_status,
          :phones_attributes => [:number, :phone_type, :_destroy],
          :children_attributes => [:first_name, :last_name, :birth_date, :_destroy] )
      when Parent::FROM_PHONE
        params.require(:parent).permit( :first_name, :last_name, :addr, :city, :state, :zip, 
          :reg_method, :email, :tour_date, 
          :phones_attributes => [:number, :phone_type, :_destroy],
          :children_attributes => [:first_name, :last_name, :birth_date, :_destroy]  )
      end
  	end

    def edit_params
      params.require(:parent).permit( :confirmed_status )
    end
end
