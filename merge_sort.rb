class MergeSort
    def initialize(value_array, threads_nbr)
        @value_array = value_array
        @threads_nbr = threads_nbr
        @size = @value_array.size

        if (@threads_nbr % 2 == 0 || @threads_nbr == 1) && @threads_nbr > 0
            segment = @size/@threads_nbr
            remainder = @size % @threads_nbr
            threads = Array.new
            start_par = Time.now
            for i in 0..(@threads_nbr-1)
                if i != @threads_nbr-1
                    Thread.new {merge_sort(i*segment, (i+1)*segment-1)}.join
                else
                    Thread.new {merge_sort(i*segment, (i+1)*segment-1+remainder)}.join
                end
            end
            if i > 1
                for i in 0..(@threads_nbr-1)
                    if i != @threads_nbr
                        merge(i*segment, (i+1)*segment-1)
                    else
                        merge(i*segment, (i+1)*segment-1+remainder)
                    end
                end
            end
            end_par = Time.now
            total_par = end_par - start_par
            puts "Code took " + total_par.to_s + " with "+ @threads_nbr.to_s + " threads"
        else
            puts "Invalid number of threads or empty array"
        end

    end
    def merge_sort(low , high)
        mid = low + (high-low)/2
        if low < high
            merge_sort(low, mid)
    
            merge_sort(mid + 1, high)
    
            merge(low, high) 
        end
    end
        

    def merge(low, high)
        mid = low + (high-low)/2
        n1 = mid - low + 1
        n2 = high - mid
        left = Array.new(n1)
        right = Array.new(n2)
    
        for i in 0..n1
            left[i] = @value_array[i + low]
        end
    
        for i in 0..n2
            right[i] = @value_array[i + mid + 1]
        end
    
        k = low
        i = 0
        j = 0
    
        while i < n1 && j < n2
            if (left[i] <= right[j]) 
                @value_array[k] = left[i]
                i+=1
            else
                @value_array[k] = right[j]
                j+=1
            k+=1
            end
        end
        while (i < n1)
            @value_array[k] = left[i];
            i+=1
            k+=1
        end
    
        while (j < n2)
            @value_array[k] = right[j]
            k+=1
            j+=1
        end
    end
end

arr = [1,2,4,6,8,10,12,14,16]
for i in arr do
    value_array = Array.new(1000000) { rand(1...100_000_000) }

    MergeSort.new(value_array, i)
end
