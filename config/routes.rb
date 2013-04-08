Notesie::Application.routes.draw do
  resources :bulletins

  resources :subjects

  devise_for :users
  resources :tasks

  resources :users

  resources :notebooks do
    resources :tasks
  end

  root to: 'home#index'
end
#== Route Map
# Generated on 08 Apr 2013 23:40
#
#                          POST   /bulletins(.:format)                             bulletins#create
#             new_bulletin GET    /bulletins/new(.:format)                         bulletins#new
#            edit_bulletin GET    /bulletins/:id/edit(.:format)                    bulletins#edit
#                 bulletin GET    /bulletins/:id(.:format)                         bulletins#show
#                          PUT    /bulletins/:id(.:format)                         bulletins#update
#                          DELETE /bulletins/:id(.:format)                         bulletins#destroy
#                 subjects GET    /subjects(.:format)                              subjects#index
#                          POST   /subjects(.:format)                              subjects#create
#              new_subject GET    /subjects/new(.:format)                          subjects#new
#             edit_subject GET    /subjects/:id/edit(.:format)                     subjects#edit
#                  subject GET    /subjects/:id(.:format)                          subjects#show
#                          PUT    /subjects/:id(.:format)                          subjects#update
#                          DELETE /subjects/:id(.:format)                          subjects#destroy
#         new_user_session GET    /users/sign_in(.:format)                         devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                         devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                        devise/sessions#destroy
#            user_password POST   /users/password(.:format)                        devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                    devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                   devise/passwords#edit
#                          PUT    /users/password(.:format)                        devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                          devise/registrations#cancel
#        user_registration POST   /users(.:format)                                 devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                         devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                            devise/registrations#edit
#                          PUT    /users(.:format)                                 devise/registrations#update
#                          DELETE /users(.:format)                                 devise/registrations#destroy
#                    tasks GET    /tasks(.:format)                                 tasks#index
#                          POST   /tasks(.:format)                                 tasks#create
#                 new_task GET    /tasks/new(.:format)                             tasks#new
#                edit_task GET    /tasks/:id/edit(.:format)                        tasks#edit
#                     task GET    /tasks/:id(.:format)                             tasks#show
#                          PUT    /tasks/:id(.:format)                             tasks#update
#                          DELETE /tasks/:id(.:format)                             tasks#destroy
#                    users GET    /users(.:format)                                 users#index
#                          POST   /users(.:format)                                 users#create
#                 new_user GET    /users/new(.:format)                             users#new
#                edit_user GET    /users/:id/edit(.:format)                        users#edit
#                     user GET    /users/:id(.:format)                             users#show
#                          PUT    /users/:id(.:format)                             users#update
#                          DELETE /users/:id(.:format)                             users#destroy
#           notebook_tasks GET    /notebooks/:notebook_id/tasks(.:format)          tasks#index
#                          POST   /notebooks/:notebook_id/tasks(.:format)          tasks#create
#        new_notebook_task GET    /notebooks/:notebook_id/tasks/new(.:format)      tasks#new
#       edit_notebook_task GET    /notebooks/:notebook_id/tasks/:id/edit(.:format) tasks#edit
#            notebook_task GET    /notebooks/:notebook_id/tasks/:id(.:format)      tasks#show
#                          PUT    /notebooks/:notebook_id/tasks/:id(.:format)      tasks#update
#                          DELETE /notebooks/:notebook_id/tasks/:id(.:format)      tasks#destroy
#                notebooks GET    /notebooks(.:format)                             notebooks#index
#                          POST   /notebooks(.:format)                             notebooks#create
#             new_notebook GET    /notebooks/new(.:format)                         notebooks#new
#            edit_notebook GET    /notebooks/:id/edit(.:format)                    notebooks#edit
#                 notebook GET    /notebooks/:id(.:format)                         notebooks#show
#                          PUT    /notebooks/:id(.:format)                         notebooks#update
#                          DELETE /notebooks/:id(.:format)                         notebooks#destroy
#                     root        /                                                home#index
