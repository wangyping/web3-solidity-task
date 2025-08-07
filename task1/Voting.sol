
    function vote(string memory candidate) public {
        candidateMap[candidate] += 1;
    }

    function getVotes(string memory candidate) public view returns(uint256) {
        return candidateMap[candidate];
    }

    function resetVotes(string[] memory candidates) public {
        for (uint256 i = 0; i < candidates.length; i++) {
            candidateMap[candidates[i]] = 0;
        }
    }

    //题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
    function revertStr(string memory str) public pure returns(string memory s) {
        bytes memory byteArray = bytes(str);
        uint byteLen = byteArray.length;
        bytes memory revertByte = new bytes(byteLen);
        for (uint i = 0; i< byteLen; i++) {
            revertByte[byteLen-i-1] = byteArray[i];
        }
        return string(revertByte);
    }

    //用 solidity 实现整数转罗马数字
    function intToRomanSimple(uint16 num) public pure returns (string memory) {
        string[13] memory symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        uint16[13] memory values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        
        bytes memory result = new bytes(50);
        uint256 index = 0;
        
        for (uint256 i = 0; i < 13; i++) {
            while (num >= values[i]) {
                bytes memory symbolBytes = bytes(symbols[i]);
                for (uint256 j = 0; j < symbolBytes.length; j++) {
                    result[index] = symbolBytes[j];
                    index++;
                }
                num -= values[i];
            }
        }
        
        bytes memory finalResult = new bytes(index);
        for (uint256 i = 0; i < index; i++) {
            finalResult[i] = result[i];
        }
        
        return string(finalResult);
    }

    //用 solidity 实现罗马数字转数整数
    function romanToInt(string memory s) public pure returns (uint16) {
        bytes memory romanBytes = bytes(s);
        uint16 result = 0;
        uint16 prevValue = 0;
        
        // 从右到左遍历罗马数字
        for (uint256 i = romanBytes.length; i > 0; i--) {
            uint16 currentValue = getValue(romanBytes[i - 1]);
            
            // 如果当前值小于前一个值，说明是减法情况（如IV, IX等）
            if (currentValue < prevValue) {
                result -= currentValue;
            } else {
                result += currentValue;
            }
            
            prevValue = currentValue;
        }
        return result;
    }

    // 获取单个罗马数字符号对应的数值
    function getValue(bytes1 romanChar) internal pure returns (uint16) {
        if (romanChar == bytes1("I")) return 1;
        if (romanChar == bytes1("V")) return 5;
        if (romanChar == bytes1("X")) return 10;
        if (romanChar == bytes1("L")) return 50;
        if (romanChar == bytes1("C")) return 100;
        if (romanChar == bytes1("D")) return 500;
        if (romanChar == bytes1("M")) return 1000;
        
        revert("Invalid Roman numeral character");
    }

    //合并两个有序数组 (Merge Sorted Array)
    function mergeArray(uint256[] memory array1, uint256[] memory array2)  public pure returns(uint256[] memory){
        uint256 array1Len = array1.length;
        uint256 array2Len = array2.length;
        uint256[] memory result = new uint256[](array1Len+array2Len);
        uint256 left1Index = 0;
        uint256 right1Index = array1Len - 1;
        uint256 left2Index = 0;
        uint256 right2Index = array2Len - 1;
        uint256 index = 0;
        while (left1Index <= right1Index && left2Index <= right2Index ) {
            if (array1[left1Index] <= array2[left2Index]) {
                result[index++] = array1[left1Index++];
            } else {
                result[index++] = array2[left2Index++];
            }
        }
        if (left1Index > right1Index) {
            while(left2Index <= right2Index) {
                result[index++] = array2[left2Index++];
            }
        }
        if (left2Index > right2Index) {
            while(left1Index <= right1Index) {
                result[index++] = array1[left1Index++];
            }
        }
        return result;
    }

    //二分查找 (Binary Search)
    //题目描述：在一个有序数组中查找目标值。
    function findValue(uint256[] memory arr, uint256 val) public pure returns(int256) {
        uint256 leftIndex = 0;
        uint256 rightIndex = arr.length - 1;
        while (leftIndex <= rightIndex) {
            uint256 middleIndex = (leftIndex + rightIndex)/2;
            if (arr[middleIndex] < val) {
                leftIndex = middleIndex + 1;
            } else if (arr[middleIndex] > val) {
                rightIndex = middleIndex - 1;
            } else {
                return int256(middleIndex);
            }
        }
        return -1;
    }

    
}
