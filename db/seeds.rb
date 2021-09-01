Like.destroy_all
Tagging.destroy_all
Tag.destroy_all
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

NUM_TAGS = 20

NUM_TAGS.times do
    Tag.create(
        name: Faker::Vehicle.make
    )
end

tags = Tag.all

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
            c = Comment.create(body: Faker::GreekPhilosophers.quote,  user: users.sample, post: p)
            c.likers = users.shuffle.slice(0, rand(users.count))
            end
        end
        p.tags = tags.shuffle.slice(0, rand(tags.count))
end

posts = Post.all
comments = Comment.all

puts "Generated #{posts.count} posts"
puts "Generated #{comments.count} comments"
puts "Generated #{users.count} users"
puts "Generated #{Like.count} likes"
puts "Generated #{Tag.count} tags"
puts "Login with #{super_user.email} and password: #{PASSWORD}"