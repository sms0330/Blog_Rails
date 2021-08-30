User.delete_all
Post.destroy_all
Comment.destroy_all

PASSWORD='0414'
super_user=User.create(
    name: 'Joseph',
    email: 'sms0330@gmail.com',
    password: PASSWORD,
    is_admin: true
)

10.times do
    name=Faker::Name.first_name
    User.create(
        name: name,
        email: "#{name}@example.com",
        password: PASSWORD
    )
end
users=User.all

100.times do
    created_at = Faker::Date.backward(days:365 * 5)
        p = Post.create(
        title: Faker::Company.industry,
        body: Faker::ChuckNorris.fact,
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
        )
        if p.valid?
            rand(1..10).times.map do
                Comment.create(body: Faker::GreekPhilosophers.quote,  user: users.sample, post: p)
            end
        end
end

posts = Post.all
comments = Comment.all

puts "Generated #{posts.count} posts"
puts "Generated #{comments.count} comments"
puts "Generated #{users.count} users"