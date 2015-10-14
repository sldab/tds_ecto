defmodule Tds.Ecto.TriggerTest do
  use Ecto.Integration.Case
  alias Ecto.Integration.TestRepo
  alias Ecto.Integration.User
  import Ecto.Query
  setup do
    Application.put_env(:tds_ecto, :tables_with_triggers, ["users"])
    Ecto.Adapters.SQL.query(TestRepo,
      "CREATE TRIGGER TEST_TRIGGER ON users FOR INSERT, UPDATE, DELETE " <>
      "AS BEGIN SET NOCOUNT ON SELECT 333333", [])
    on_exit fn ->
      Application.delete_env(:ecto, :tables_with_triggers)
    end
  end

  @tag :triggers
  test "insert into table with insert trigger" do
    assert %User{} = TestRepo.insert!(%User{name: "Tester"})
  end

  @tag :triggers
  test "update on table with insert trigger" do
    assert %User{} = user = TestRepo.insert!(%User{name: "Tester"})
    user = %{user | name: "TESTER"}
    assert %User{} = TestRepo.update!(user)
  end

  @tag :triggers
  test "delete on table with insert trigger" do
    assert %User{} = user = TestRepo.insert!(%User{name: "To be deleted"})
    assert %User{} = TestRepo.delete!(user)
  end

  @tag :triggers
  test "update all on table with insert trigger" do
    assert %User{} = TestRepo.insert!(%User{name: "Alice"})
    assert %User{} = TestRepo.insert!(%User{name: "Alice"})
    query = from(u in User, where: u.name == "Alice")
    assert {2, nil} = TestRepo.update_all(query, set: [name: "Bob"])
  end
end
