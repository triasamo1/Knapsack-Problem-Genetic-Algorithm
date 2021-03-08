function total_value = my_fitness(chroms)
    % import xls file 
    data1 = importdata('knapsack.xls');
    % extract data
    bag_size = data1(1,1);
    total_items = data1(2,1);
    pr_id = data1(3:102,1).';
    sizeof = data1(3:102,2).';
    valueof = data1(3:102,3).';
    for i= 1:size(chroms,1)
        % Calculate the fitness score of each solution
        value_SUM=sum(chroms(i,:).* valueof);
        weight_SUM=sum(chroms(i,:).* sizeof);
        if weight_SUM <= bag_size
            total_value(i)= value_SUM;
        else
            % penaltize solutions that exceed the weight limit
            total_value(i) = -value_SUM;
        end
    end
end