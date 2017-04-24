FROM cloudgear/ruby:2.2

ADD ./setup /setup

# Build essentials
RUN apt-get update
RUN apt-get install -y curl build-essential git

WORKDIR /setup

# Mecab
RUN tar -xzf mecab-0.996.tar.gz
RUN cd mecab-0.996; ./configure --enable-utf8-only; make; make install; ldconfig

# Ipadic
RUN tar -xzf mecab-ipadic-2.7.0-20070801.tar.gz
RUN cd mecab-ipadic-2.7.0-20070801; ./configure --with-charset=utf8; make; make install
RUN echo "dicdir = /usr/local/lib/mecab/dic/ipadic" > /usr/local/etc/mecabrc

# Ve
RUN git clone https://github.com/Kimtaro/ve.git
RUN cd ve; gem build ve.gemspec; gem install ve-0.0.3.gem

# Clean up
RUN apt-get remove -y build-essential
RUN rm -rf /setup  

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . ./

EXPOSE 3000

RUN bin/rake db:schema:load && bin/rake db:seed

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
