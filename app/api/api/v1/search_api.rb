module Api::V1
  class SearchApi < Grape::API          
    namespace :search do
      helpers do                            
        def search_post 
          @p = []
          @result = []
          if params[:max_price] && params[:min_price] && params[:type_house]
            @id.each do |y|          
              @p.push(Post.where("posts.id = ? AND posts.price <= ? AND posts.price >= ? AND posts.type_house = ?",y ,params[:max_price] ,params[:min_price] ,params[:type_house]))           
            end 
            @p.reject { |c| c.empty? }
          end 
          if params[:max_price] && params[:min_price] 
            @id.each do |y|          
              @p.push(Post.where("posts.id = ? AND posts.price <= ? AND posts.price >= ?",y ,params[:max_price] ,params[:min_price]))           
            end 
            @p.reject { |c| c.empty? }
          end 
        end       
      end    
      # method GET
      namespace :search_multi do       
        params do       
          optional :city,         type: String
          optional :district,     type: String
          optional :min_price,    type: Integer
          optional :max_price,    type: Integer 
          optional :type_house,   type: Integer           
        end
        get do
          if params[:city] && params[:district]
            @id = []        
            arr = Address.where(city: params[:city], district: params[:district])
            arr.each do |i|            
              @id.push(i.post_id)           
            end   
            search_post
          end         
          if params[:city]
            @id = []        
            arr = Address.where(city: params[:city])
            arr.each do |i|            
              @id.push(i.post_id)           
            end   
            search_post
          end          
          if params[:district]
            @id = []        
            arr = Address.where(district: params[:district])
            arr.each do |i|            
              @id.push(i.post_id)           
            end   
            search_post
          else 
            @id = []        
            arr = Address.all
            arr.each do |i|            
              @id.push(i.post_id)           
            end   
            search_post  
          end                     
        end
      end
      # get posts  - type house
      namespace :search_type_house do       
        params do          
          optional :type_house, type: Integer           
        end
        get do         
          Post.where("posts.type_house = ? " ,params[:type_house])                     
        end
      end


    end     
  end
end