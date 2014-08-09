# Config for Key-Value Database
class YakvdConfig
  def self.yakvd_config
    {
        # Used storage class name
        # supported: 'BtreeStorage', 'HashStorage'
        storage_name: 'BtreeStorage',
        # Database file. Uses TSV (
        #   tab separated values - YakvdConstants.delimiter
        # )
        #TODO: сбрасывать данные на диск периодически
        filename: 'data/storage.csv'
    }
  end
end
