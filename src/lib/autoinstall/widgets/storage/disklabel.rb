# Copyright (c) [2020] SUSE LLC
#
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, contact SUSE LLC.
#
# To contact SUSE LLC about this file by physical or electronic mail, you may
# find current contact information at www.suse.com.

require "yast"
require "cwm/common_widgets"
require "y2storage"

module Y2Autoinstallation
  module Widgets
    module Storage
      # Widget to set the type of partition table to use
      #
      # It corresponds to the `disklabel` element in the profile.
      class Disklabel < CWM::ComboBox
        # Constructor
        def initialize
          textdomain "autoinst"
          super
        end

        # @macro seeAbstractWidget
        def label
          _("Disklabel")
        end

        # We are only interested in these types.
        # @see https://github.com/openSUSE/libstorage-ng/blob/efcbcdaa830822c5fc7545147958696efbfed514/storage/Devices/PartitionTable.h#L43
        TYPES = [
          Y2Storage::PartitionTables::Type::GPT,
          Y2Storage::PartitionTables::Type::MSDOS,
          Y2Storage::PartitionTables::Type::DASD
        ].freeze
        private_constant :TYPES

        # @return [Array<Array<String,String>>] List of possible values
        def items
          return @items if @items

          @items = TYPES.map do |type|
            [type.to_s, type.to_human_string]
          end
          @items << ["none", _("None")]
          @items
        end
      end
    end
  end
end
