defmodule FlightexTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingsAgent

  describe "start_agents/1" do
    test "starts the agents" do
      Flightex.start_agents()

      expected_response = {:ok, %{}}

      assert BookingsAgent.get_all() == expected_response
      assert UserAgent.get_all() == expected_response
    end
  end

  describe "create_or_update_user/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when all params are valid, returns the a success message" do
      user = %{
        name: "Jp",
        email: "jp@banana.com",
        cpf: "12345678900"
      }

      response = Flightex.create_or_update_user(user)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end
  end

  describe "create_or_update_booking/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when all params are valid, returns the a success message" do
      booking = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900"
      }

      response = Flightex.create_or_update_booking(booking)

      {:ok, id} = response

      expected_response = {:ok, id}

      assert response == expected_response
    end
  end
end
