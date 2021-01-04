require "minitest/autorun"
require "./account"
require "./amount"
class AccountTest < MiniTest::Test
    def setup
        @account = Account.new("test_account")
    end

    def test_main
        @account.deposit(:rebel, 2000)
        @account.deposit(:rebel, 2020)
        assert_equal(Amount.new(:rebel, 4020), @account.balance)
    end

    def test_cross
        @account.deposit(:rebel, 10000)
        @account.deposit(:nok, 10000)
        assert_equal(Amount.new(:rebel, 22000), @account.balance)
    end

    def test_withdrawal_failing
        @account.deposit(:rebel, 10000)
        assert_raises Account::InvalidTransaction do
            @account.withdraw(:rebel, 10001)
        end
    end

    def test_simple_cross
        a = Amount.new(:nok, 10000)
        b = a.to_currency(:rebel)
        expected = Amount.new(:rebel, 12000)
        assert_equal(expected, b)
    end

    def test_load
        @account.load([
            [:rebel, 10000],
            [:rebel, 10000]
        ])
        assert_equal(Amount.new(:rebel, 20000), @account.balance)
    end

    def test_dump_to_file
        @account.deposit(:rebel, 2000)
        @account.deposit(:rebel, 2020)
        @account.dump_state
    end

    def test_reset_state
        @account.deposit(:rebel, 20000)
        @account.deposit(:rebel, 20000)
        @account.dump_state
        @account.deposit(:rebel, 20000) # Should be ignored below
        @account.reset_state
        assert_equal(Amount.new(:rebel, 40000), @account.balance)
    end
end