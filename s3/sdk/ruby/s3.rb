require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

# 'bundle exec ruby s3.rb' to run program

# example usage: BUCKET_NAME='my-bucket' bundle exec ruby s3.rb
bucket_name = ENV['BUCKET_NAME'] # Get bucket name from environment variable
region = 'ca-central-1' # Define the region for the S3 bucket

# Gitpod loads credentials from environment variables. Another approach is putting them in .aws/credentials 
# and then passing it like: AWS::S3::Client.new(region: region_name, credentials: credentials, ..)
client = Aws::S3::Client.new # Create an S3 client instance

# Create a new S3 bucket
resp = client.create_bucket({
    bucket: bucket_name, # The name of the bucket to create
    create_bucket_configuration: {
        location_constraint: region # Specify the region for the bucket
    }
})
# binding.pry

# Generate a random number of files to upload (between 1 and 6)
number_of_files = 1 + rand(6)

puts "number_of_files: #{number_of_files}" # Output the number of files to be created and uploaded

# Loop to create and upload files to the S3 bucket
number_of_files.times.each do |i|
    puts "i: #{i}" # Print the current iteration index
    filename = "file_#{i}.txt" # Generate a unique filename for each iteration
    output_path = "/tmp/#{filename}" # Define the local path for the temporary file

    # Create a temporary file and write a unique UUID to it
    File.open(output_path, "w") do |file|
        file.write(SecureRandom.uuid) # Write a random UUID to the file
    end

    # Upload the file to the S3 bucket
    File.open(output_path, 'rb') do |file|
        client.put_object(
            bucket: bucket_name, # Specify the bucket name
            key: filename, # Specify the key (file name) in the bucket
            body: file # Specify the file to upload
        )
    end
end
