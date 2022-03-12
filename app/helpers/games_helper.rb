module GamesHelper
    def format_condition(condition)
        condition.gsub("_", " ").titleize
    end

    def format_price(price)
        "$#{price/100}"
    end
end
