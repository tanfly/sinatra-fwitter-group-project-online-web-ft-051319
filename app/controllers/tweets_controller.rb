class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else 
            redirect '/login'
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'/tweets/new'
        else 
            redirect '/login'
        end
    end

    post '/tweets/new' do 
        if logged_in?
            @user = current_user
            @user.tweets << Tweet.create(:content => params[:content]) unless params[:content].empty?
        end 
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if !params[:content].empty?
                @tweet.update(content: params[:content])
                redirect "/tweets/#{@tweet.id}"
            else
                redirect redirect "/tweets/#{@tweet.id}/edit"
            end
        else 
            redirect '/login'
        end
    end

    delete '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet.user == current_user
                @tweet.delete
                redirect '/tweets'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end



end
