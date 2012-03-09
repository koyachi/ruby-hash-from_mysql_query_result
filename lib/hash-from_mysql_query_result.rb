require "hash-from_mysql_query_result/version"

class Hash
  module FromMysqlQueryResult
    class << self
      private
      PARSE_STATUS = {
        :header => 1,
        :table_header => 2,
        :table_body => 3,
        :table_footer => 4,
        :footer => 5
      }
      TABLE_FRAME_PATTERN = /\+\-+\+/

      def process_header(lines)
        result = []
        lines.each_with_index do |line, i|
          return result if i != 0 && line.match(TABLE_FRAME_PATTERN)
          
          line.chomp!
          result.push(line)
        end
        result
      end

      def process_table_header(lines)
        lines.each_with_index do |line, i|
          return if i != 0 && line.match(TABLE_FRAME_PATTERN)
          next if i == 0 && line.match(TABLE_FRAME_PATTERN)
          
          line.chomp!
          headers = line.gsub(/\s/, "").split("|")[1..-1]
          return headers
        end
      end
      
      def process_table_body(lines)
        result = []
        lines.each_with_index do |line, i|
          return result if i != 0 && line.match(TABLE_FRAME_PATTERN)
          next if i == 0 && line.match(TABLE_FRAME_PATTERN)
          
          line.chomp!
          rows = line.gsub(/\s/, "").split("|")[1..-1]
          result.push(rows)
        end
        result
      end

      def process_table_footer(lines)
        result = []
        lines.each_with_index do |line, i|
          return result if i != 0 && line.match(TABLE_FRAME_PATTERN)
          next if i == 0 && line.match(TABLE_FRAME_PATTERN)
          
          line.chomp!
          result.push(line)
        end
        result
      end

      def process_footer(lines)
#        puts "[PROCESS_FOOTER]"
#        lines.each do |line|
#          puts "  #{line}"
#        end
      end
      
      public
      def process_file(path)
        file = open(path)
        parse_text(file.read)
      end

      def parse_text(text)
        result = {
          :header => "",
          :fields => [],
          :records  => [],
          :footer => ""
        }
        state = PARSE_STATUS[:header]
        lines = text.lines.to_a
        text.lines.each_with_index do |line, i|
          if line.match(TABLE_FRAME_PATTERN)
            case state
            when PARSE_STATUS[:table_header]
              result[:fields] = process_table_header(lines[i..-1])
              state = PARSE_STATUS[:table_body]
              
            when PARSE_STATUS[:table_body]
              records = process_table_body(lines[i..-1])
              tmp_records = []
              records.each_with_index do |record, i|
                tmp = {}
                result[:fields].each_with_index do |key, i|
                  tmp[key] = record[i]
                end
                tmp_records.push(tmp)
              end

              result[:records] = tmp_records
              state = PARSE_STATUS[:table_footer]
              
            when PARSE_STATUS[:table_footer]
              result[:footer] = process_table_footer(lines[i..-1])
              state = PARSE_STATUS[:footer]
              
            when PARSE_STATUS[:footer]
              process_footer(lines[i..-1])
              
            end

          else
            case state
            when PARSE_STATUS[:header]
              result[:header] = process_header(lines[i..-1])
              state = PARSE_STATUS[:table_header]
            end
          end
        end
        result
      end

    end
  end
end
