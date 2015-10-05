# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create!([
                    {email: 'nyan@user.com', name: 'Nyan', surname: 'Nyanov', password: 'qwertyui', password_confirmation: 'qwertyui'},
                    {email: 'cat@user.com', name: 'Cat', surname: 'Catov', password: 'qwertyui', password_confirmation: 'qwertyui'}
                  ])

posts = Post.create!([
                    {title: 'NyanPost', user_id: 1, text: 'Nyan Cat Rulezzzz!', date: Time.now, image: 'tyan1.jpg'},
                    {title: 'LoLPost', user_id: 1, text: 'Trololo!', date: Time.now, image: nil},
                    {title: 'CatPost', user_id: 2, text: 'Cats Rulezzzz!', date: Time.now, image: 'tyan2.jpg'},
                    {title: 'LittlePost', user_id: 2, text: '^__^', date: Time.now, image: 'tyan3.jpg'}
                  ])

tags = Tag.create!([
                  {name: "NyanCat"},
                  {name: "TrollFace"},
                  {name: "Sukas"},
                  {name: "Cats"},
                  {name: "Trap"},
                  {name: "Death"}
                ])

post_tags = PostTag.create!([
                          {post_id: 1, tag_id: 1},
                          {post_id: 1, tag_id: 4},

                          {post_id: 2, tag_id: 2},
                          {post_id: 2, tag_id: 5},
                          {post_id: 2, tag_id: 6},

                          {post_id: 3, tag_id: 4},
                          {post_id: 3, tag_id: 6},

                          {post_id: 4, tag_id: 3},
                          {post_id: 4, tag_id: 5},
                          {post_id: 4, tag_id: 6}
                        ])

comments = Comment.create!([
                          {message: 'Nya!', post_id: 1, user_id: 2},
                          {message: 'Hey!', post_id: 1, user_id: 1},

                          {message: 'Мыло со стола или хлеб с параши?', post_id: 2, user_id: 2},
                          {message: 'Хлеб с параши.', post_id: 2, user_id: 1},
                          {message: '(((', post_id: 2, user_id: 2},

                          {message: 'Nya!', post_id: 4, user_id: 1},
                          {message: 'Suck my balls!', post_id: 4, user_id: 2}
                        ])