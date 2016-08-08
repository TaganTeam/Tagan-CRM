class Managment::InventoriesController < AppManagmentController
  def index
    inventoryList = Inventory.all
    typeList = Type.all

    @groupedList = {}
    @typedList = {}
    @resultList = {}
    @counts = Hash.new(0)
    @countsfree = Hash.new(0)
    typeList.each do |item|
      @typedList[item.id] = item.name
    end
    inventoryList.each do |item|
      @groupedList[item.id] = @typedList[item.type_id]

      if item.user_id == nil
        @countsfree[@groupedList[item.id]] += 1
      end
        @counts[@groupedList[item.id]] += 1
    end
    @groupedList = @groupedList.values.uniq
  end

  def new
    @type = Type.all
  end

  def create
    c = params[:count_inv].to_i
    c.times do
      @inventory = Inventory.new(inventory_params)
      respond_to do |format|
        if  @inventory.save
          format.json {
            render json: @inventory.as_api_response(:basic)
          }
        end
      end
    end
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def all
    @inventories = Inventory.all
    typeList = Type.all
    @typedList = {}
    typeList.each do |item|
      @typedList[item.id] = item.name
    end
  end

  def show
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.html { render "managment/inventories/show" }
      format.json {
        render json: @inventory.as_api_response(:basic)
      }
    end
  end

  def upload
    data = params[:data]
    filename = params[:filename]

    ## Decode the image
    data_index = data.index('base64') + 7
    filedata = data.slice(data_index, data.length)

    decoded_image = Base64.decode64(filedata)
    ## Write the file to the system
    File.open("public/uploads/#{filename}", "w+") {|f| f.write(decoded_image.force_encoding("UTF-8")) }
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    respond_to do |format|
      format.html { redirect_to managment_inventories_path, notice: 'Inventory was successfully destroyed.' }
    end
  end

  def update
    @inventory = Inventory.find(params[:id])
    puts '==========================='

    puts '============================'
    if @inventory.update(inventory_params)
      respond_to do |format|
        format.json {
          render json: @inventory.as_api_response(:basic)
        }
      end
    end
  end

  def inventory_params
    params.require(:inventory).permit(:user_id, :type_id, :inventory_id, :receipt_date, :avatar)
  end

end

