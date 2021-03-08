clc;
clear;

%----------------------Initialize variables---------------------
total_items=100;
population=100;
mutation_rate=0.1;
max_generations=100;   
max_epochs=15;
temp1=0;
number_mutations = mutation_rate * total_items;
chroms = round(rand(population,total_items)); %random chromosomes

%----------------------start Genetic Algorithm---------------------
 for generation = 1:max_generations
    % generate the fitness value of all chromosomes
    total_value = my_fitness(chroms); 
    % rank the chromosomes with descending order 
    [total_value,index] = sort(total_value, 'descend'); 
    % re-arrange chromosomes
    chroms = chroms(index(1:population),:);  
    half_population = population / 2;
    disp(['generation :', num2str(generation) ,' Total Value :', num2str(total_value(1))])
    
    %-----------------Crossover------------------
    for i=1:2:half_population  
        % the first half of the pupulation will be parents
        crossing_point1 = ceil(1 + (100-1)*rand); %generate a random crossing point between [1,100]
        crossing_point2 = ceil(1 + (100-1)*rand); %generate a random crossing point between [1,100]
        % make sure: cross1 < cross2
        if (crossing_point1>crossing_point2)   
            temp=crossing_point2;
            crossing_point2=crossing_point1;
            crossing_point1=temp;
        end  
        % 1st child is identical to parent1 inheriting a part of parent2(crossing_point1:crossing_point2)
        chroms(population+1-i,:) = chroms(i,:);  
        chroms(population+1-i,crossing_point1:crossing_point2) = chroms(i+1,crossing_point1:crossing_point2); 
        % 2nd child is identical to parent2 inheriting a part of parent1(crossing_point1:crossing_point2)
        chroms(population-i,:) = chroms(i+1,:);   
        chroms(population-i,crossing_point1:crossing_point2) = chroms(i,crossing_point1:crossing_point2); 
    end
    % let the first 4 parents migrate and survive to next generation
    chroms(5:half_population,:) = round(rand(half_population-4,total_items)); %random chromosomes 
    
    %----------------------------Mutations------------------------------
    for n = 1:number_mutations
        % at random chromosome
        x = ceil(population * rand);
        % at random gene
        y = ceil(total_items * rand);
        chroms(x,y)= 1 - chroms(x,y);
    end
    
    % Check if best solution hasn't changed for more than max_epochs
    if (temp1 == total_value(1))
        count = count +1;
    else
        count=1;
    end
    temp1=total_value(1);
    if (count>=max_epochs)
        break
    end
 end