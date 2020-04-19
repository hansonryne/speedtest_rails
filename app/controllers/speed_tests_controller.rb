# frozen_string_literal: true

class SpeedTestsController < ApplicationController
  before_action :set_speed_test, only: %i[show edit update destroy]

  # GET /speed_tests
  # GET /speed_tests.json
  def index
    #Getting the number of speedtests to display
    params[:max_records] ? @records_to_show = params[:max_records] : @records_to_show = 10
    @records = SpeedTest.all.order(created_at: 'desc').limit(@records_to_show)

    # Ping speeds and averages from number of records selected
    @pings = SpeedTest.get_pings(@records.to_a)
    @ping_avg = @pings.map{|ping| ping[1].to_f}.inject(:+) / @pings.size.to_f

    # Download speeds and averages from number of records selected
    @download_speeds = SpeedTest.get_download_speed(@records.to_a)
    @down_avg = @download_speeds.map{|down| down[1].to_f}.inject(:+) / @download_speeds.size.to_f

    # Upload speeds and averages from number of records selected
    @upload_speeds = SpeedTest.get_upload_speed(@records.to_a)
    @up_avg = @upload_speeds.map{|up| up[1].to_f}.inject(:+) / @upload_speeds.size.to_f
    
    # Number of tests for each server
    @bar_chart = SpeedTest.all.group(:server).count
    
    # Most recent test
    @last_test = SpeedTest.last

    # Test results grouped by server
    @servers = SpeedTest.all.group_by(&:server)

    # Getting average download speed for each server
    @average_ping = {}
    @servers.each do |server, testarr|
      @average_ping[server] = testarr.map{|item| item.ping.to_f}.inject(:+) / testarr.size.to_f
    end
    @average_up = {}
    @servers.each do |server, testarr|
      @average_up[server] = testarr.map{|item| item.upload.to_f}.inject(:+) / testarr.size.to_f
    end
    @average_down = {}
    @servers.each do |server, testarr|
      @average_down[server] = testarr.map{|item| item.download.to_f}.inject(:+) / testarr.size.to_f
    end
    # Choose the server with the best download speed
    @best_download_server = @average_down.max_by{|k,v| v}
  end

  # GET /speed_tests/1
  # GET /speed_tests/1.json
  def show; end

  # GET /speed_tests/new
  def new
    @speed_test = SpeedTest.new
  end

  # GET /speed_tests/1/edit
  def edit; end

  # POST /speed_tests
  # POST /speed_tests.json
  def create
    @speed_test = SpeedTest.new(speed_test_params)

    respond_to do |format|
      if @speed_test.save
        format.html { redirect_to @speed_test, notice: 'Speed test was successfully created.' }
        format.json { render :show, status: :created, location: @speed_test }
      else
        format.html { render :new }
        format.json { render json: @speed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speed_tests/1
  # PATCH/PUT /speed_tests/1.json
  def update
    respond_to do |format|
      if @speed_test.update(speed_test_params)
        format.html { redirect_to @speed_test, notice: 'Speed test was successfully updated.' }
        format.json { render :show, status: :ok, location: @speed_test }
      else
        format.html { render :edit }
        format.json { render json: @speed_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speed_tests/1
  # DELETE /speed_tests/1.json
  def destroy
    @speed_test.destroy
    respond_to do |format|
      format.html { redirect_to speed_tests_url, notice: 'Speed test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_speed_test
    @speed_test = SpeedTest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def speed_test_params
    params.require(:speed_test).permit(:ping, :upload, :download, :server, :max_records)
  end
end
