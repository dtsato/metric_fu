module MetricFu

  def self.graph
    @graph ||= Graph.new
  end

  class Graph
    
    attr_accessor :clazz
    
    def initialize
      self.clazz = []
    end
    
    def add(graph_type)
      grapher_name = graph_type.to_s.capitalize + "Grapher"
      self.clazz.push MetricFu.const_get(grapher_name).new
    end
    
    
    def generate
      return if self.clazz.empty?
      puts "Generating graphs"
      MetricFu.each_historical_report do |date, metrics|
        puts "Generating graphs for #{date}"
        
        self.clazz.each do |grapher|
          grapher.get_metrics(metrics, date)
        end
      end
      self.clazz.each do |grapher|
        grapher.graph!
      end
    end
  end
end