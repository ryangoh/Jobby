# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def template_syntax
  me = Job.new({
    :title => 'woohoo',
    :duration => 'a year',
    :budget => BigDecimal.new('200.00'),
    :description => 'this gonna be a easy job',
    :create_by => 1})

  me = User.new({
    :email => 'test4@test.co',
    :password => '123qweasd',
    :confirmed_at => Time.now,
    :name => 'testuser4'})
end

def seed_users
  if (User.find_by(:email=>'adric@jobby.com') != nil)
    return
  end

  User.create({
    :email => 'adric@jobby.com',
    :password => 'adricang',
    :confirmed_at => Time.now,
    :name => 'Adric Ang'})
  User.create({
    :email => 'zyfoo@jobby.com',
    :password => 'foozhiyuan',
    :confirmed_at => Time.now,
    :name => 'Zhi Yuan'})
  User.new({
    :email => 'ryan@jobby.com',
    :password => 'gohek123',
    :confirmed_at => Time.now,
    :name => 'Ryan Goh'})
  User.create({
    :email => 'ywwan@jobby.com',
    :password => 'yinwai12',
    :confirmed_at => Time.now,
    :name => 'Yin Wai'})
  User.create({
    :email => 'jylow@jobby.com',
    :password => 'lowjiayou',
    :confirmed_at => Time.now,
    :name => 'Jia You'})
end

def job_one
  Job.create({
    :title => 'Expert Responsive Web Designer / Front-End Coder Wanted for Ongoing Work',
    :duration => 'Two Week',
    :budget => BigDecimal.new('1500.00'),
    :description => 'Hello there!

  We are looking for an "EXPERT" Professional Responsive Web Designer and Front-end Coder to customize a Wordpress theme. This job will consist of a series of 3 projects. You will first be given a test project to see if your design and front-end coding skills are a good fit for our high quality standards.',
    :create_by => rand(1..User.count)})
end
def job_two
  Job.create({
    :title => 'EBook / Magazine graphic designer',
    :duration => '3 to 6 months',
    :budget => BigDecimal.new('200.00'),
    :description => 'We are searching for an eBook /Magazine graphic design superstar to turn documents into a work of art. The ebook requires a cover and some internal graphics to make it come alive. ',
    :create_by => rand(1..User.count)})
end
def job_three
  Job.create({
    :title => 'Talented graphic designer to create compelling YouTube thumbnails',
    :duration => 'More than 6 months',
    :budget => BigDecimal.new('1500.00'),
    :description => 'We are searching for an eBook /Magazine graphic design superstar to turn documents into a work of art. The ebook requires a cover and some internal graphics to make it come alive. ',
    :create_by => rand(1..User.count)})
end
def job_four
  Job.create({
    :title => 'Three.js : Create an HTML5 Canvas animations from JSON data',
    :duration => '10 days',
    :budget => BigDecimal.new('400.00'),
    :description => 'I have proper structured data in the form of JSON and a sample video design using that data. I need a three.js script which uses that JSON data to create HTML Canvas animations on any browser with maximum efficiency. If necessary, use any other JS library for efficiency and flexibility. The rendering has to be smooth and scalable. Here is the video design that needs to be created in the form of HTML Canvas animations using Three.js. https://youtu.be/lT87P3wtKg8',
    :create_by => rand(1..User.count)})
end
def job_five
  Job.create({
    :title => 'Photo retoucher',
    :duration => '5 days',
    :budget => BigDecimal.new('50.00'),
    :description => 'Im looking for a retoucher to work on 35 family outdoors photos, I need someone experienced to do a clean work, my main concern is the coloring, please reply with your before and after portfolio, price and delivery time, please dont apply if you cant reply fast or you dont have the time to work',
    :create_by => rand(1..User.count)})
end
def job_five
  Job.create({
    :title => 'Photo retoucher',
    :duration => '5 days',
    :budget => BigDecimal.new('50.00'),
    :description => 'Im looking for a retoucher to work on 35 family outdoors photos, I need someone experienced to do a clean work, my main concern is the coloring, please reply with your before and after portfolio, price and delivery time, please dont apply if you cant reply fast or you dont have the time to work',
    :create_by => rand(1..User.count)})
end
def job_six
  Job.create({
    :title => 'Pro Track and Trace / Proof of Delivery',
    :duration => '5 days',
    :budget => BigDecimal.new('50.00'),
    :description => 'Im looking for a retoucher to work on 35 family outdoors photos, I need someone experienced to do a clean work, my main concern is the coloring, please reply with your before and after portfolio, price and delivery time, please dont apply if you cant reply fast or you dont have the time to work',
    :create_by => rand(1..User.count)})
end
def job_seven
  Job.create({
    :title => 'Long term RoR project / work with Toptal leader',
    :duration => '1 to 3 months',
    :budget => BigDecimal.new('6000.00'),
    :description => 'GobGob is a beach house rental website targeted at people in Kuwait looking for a short getaway close to home. We prequalify beach houses and offer them for rental on gobgob.com.

    I would like an experienced developer to join the team pf developers who are currently building the product using Ruby on Rails.

    Our lead developer is a Toptal team leader. So, in addition to earning your hourly rate, you will get an opportunity to work and learn from him.',
    :create_by => rand(1..User.count)})
end

def seed_jobs
  if (Job.count > 0)
    return
  end
  job_one
  job_two
  job_three
  job_four
  job_five
  job_six
  job_seven
end

#seed_users
seed_jobs
