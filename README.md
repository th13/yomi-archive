# yomi
Created as a project for CEN4020 Software Engineering I

Setup Instructions
------------------
1. Have Ruby and the bundler gem installed.
2. Clone this repo.
3. Install [MeCab](http://taku910.github.io/mecab/).
4. Create a `secrets.yml` file. See [Section 2.2](http://guides.rubyonrails.org/4_1_release_notes.html) here for more info.
5. Migrate the db. `bin/rake db:migrate RAILS_ENV=development`
6. `bin/rails server`

Developers
----------
* Trevor Helms
* Mike Anderson
* Elliot Rauchwerger
