class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase  # Strip spaces and downcase the email
    puts "Authenticating with email: '#{email}'"  # Debug: print the email being used

    # Find the user with case-insensitive email match
    user = User.find_by("LOWER(email) = ?", email)

    # Debugging: Check if user is found
    if user
      puts "User found: #{user.email}"  # Debug: print the user's email if found
    else
      puts "No user found with email: #{email}"  # Debug: print if no user is found
    end

    # Check if user exists and password is correct
    if user && user.authenticate(password)
      puts "Password is correct for user: #{user.email}"  # Debug: print when password matches
    else
      puts "Password is incorrect or user is nil"  # Debug: print if password is incorrect or user is nil
    end

    user && user.authenticate(password)
  end
end