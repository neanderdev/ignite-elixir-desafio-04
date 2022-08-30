defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  alias Flightex.Bookings.Report

  describe "generate/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params = %{
        complete_date: ~N[2001-05-07 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
        id: UUID.uuid4()
      }

      content = "12345678900,Brasilia,Bananeiras,2001-05-07 12:00:00"

      Flightex.create_or_update_booking(params)

      genarate_params = %{
        date_init: ~N[2000-05-07 12:00:00],
        date_final: ~N[2002-05-07 12:00:00],
        filename: "report-test.csv"
      }

      Report.generate(genarate_params)
      {:ok, file} = File.read("report-test.csv")

      assert file =~ content
    end
  end
end
