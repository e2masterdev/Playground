module StringExtensions
  class String
    def contains_lowercase_letters
      return self.match('/[a-z]/');
    end

    def contains_uppercase_letters
      return self.match('/[A-Z]/');
    end

    def contains_digits
      return self.match('/\d/');
    end
  end
end