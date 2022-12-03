#!/usr/bin/ruby

require 'sqlite3'

def executeQuery(dbName, query)
    begin
        db = SQLite3::Database.new dbName
        stm = db.prepare query
        rs = stm.execute
        
        return rs
        
    rescue SQLite3::Exception => e 
        
        puts "Exception occurred"
        puts e
        
    ensure
        stm.close if stm
        db.close if db
    end
end

def executeSelectQuery(dbName, query)
    begin
        db = SQLite3::Database.new dbName
        db.results_as_hash = true
        stm = db.prepare query
        rs = stm.execute
        output = []
        
        while(row = rs.next)
            output.push(row);
        end
        
        return output
        
    rescue SQLite3::Exception => e 
        
        puts "Exception occurred"
        puts e
        
    ensure
        stm.close if stm
        db.close if db
    end
end