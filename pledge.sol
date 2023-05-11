pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;


interface IBEP20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint256);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
  // Empty internal constructor, to prevent people from mistakenly deploying
  // an instance of this contract, which should be used via inheritance.
  constructor () internal { }

  function _msgSender() internal view returns (address payable) {
    return msg.sender;
  }

  function _msgData() internal view returns (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return sub(a, b, "SafeMath: subtraction overflow");
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    uint256 c = a - b;

    return c;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return div(a, b, "SafeMath: division by zero");
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    // Solidity only automatically asserts when dividing by 0
    require(b > 0, errorMessage);
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    return mod(a, b, "SafeMath: modulo by zero");
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts with custom message when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b != 0, errorMessage);
    return a % b;
  }
}

interface IPancakePair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

library PancakeLibrary {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'PancakeLibrary: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'PancakeLibrary: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'00fb7f630766e6a796048ea87d01acd3068e8ff67d078148a3fa3f4a84f69bd5' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        pairFor(factory, tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IPancakePair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'PancakeLibrary: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'PancakeLibrary: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(9975);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(10000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'PancakeLibrary: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(10000);
        uint denominator = reserveOut.sub(amountOut).mul(9975);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'PancakeLibrary: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'PancakeLibrary: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

// interface ISwap {
//     function swapExactTokensForTokens(uint256 amountIn, uint256 amountOutMin, address[] calldata path, address to, uint256 deadline) external returns (uint[] memory amounts);
//     function addLiquidity(address tokenA, address tokenB, uint256 amountADesired, uint256 amountBDesired, uint256 amountAMin, uint256 amountBMin, address to, uint256 deadline) external returns (uint amountA, uint amountB, uint liquidity);
// }

interface IExchangeSwap{
  function swap(address swapContract, uint256 amount, address to) external returns (uint256[] memory);
   function liquidityCalculator(address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin
    ) external view returns (uint256 amountA, uint256 amountB);
  function addLiquidity(address tokenA, address tokenB, uint256 amountADesired, uint256 amountBDesired, uint256 amountAMin, uint256 amountBMin, address to, uint256 deadline) external returns (uint256 ,
            uint256 ,
            uint256 );
  function removeLiquidity(address tokenA, address tokenB, uint256 liquidity, uint256 amountAMin, uint256 amountBMin, address to, uint256 deadline) external  returns (uint256 , uint256 );
}

contract Free_Pledge {


    using SafeMath for uint;

    struct LockInformation{
        uint _type;     // 1 lock 100 days, until reach the time, can release, // 2 lock 100 days, each day can release 1%, // 3 no lock
        uint pledge_type; // 1 pledge from fpt + usdt, 2 pledege from free + usdt 
        uint lockAmount;
        uint releasedAmount;
        uint latestReleasedTime;
        uint totalReleaseDay;
        uint d;
        uint status;
    }
    struct User{
        bytes32 [] allKey;
        mapping(bytes32 => LockInformation) informations;
        uint lpAmount;
    }


    mapping(address => User) public users;

    mapping(address => bool) public isWhitelisted;

    address [] whitelist;

    address public owner;
    
    address public usdtAddress = address(0);
    address public freeAddress = address(0);
    address public fptAddress = address(0);
    address public lpAddress = address(0);
    address public poolAddress = address(0);
    address public exchagneSwap = address(0);
    address public daoAddress = address(0);


    uint constant lockTime2 = 180; // 180 days
    uint constant lockTime = 100; // 100 daysasd
    uint public releaseRate = 100;
    uint public stepTime = 1 days;   // test set to 1 minutes, for stable use set to 1 days
    uint public startTime;
    uint public stakeFeeRate = 0;

    event Pledged(address indexed addr, bytes32 indexed _id, uint indexed _type,  uint amount, uint timestamp ,uint pledge_type);
    event Released(address indexed addr, bytes32 indexed _id, uint indexed amount, uint timestamp);
    event PledgeFinished(address indexed addr, bytes32 indexed _id, uint timestamp);
    event PledgeChanged(address indexed addr, bytes32 indexed oldId, bytes32 indexed newId, uint timestamp);

    bool isInitialized = false;

    mapping (bytes32=>bool) orderCheck;

    constructor(address uAddr, address free, address lp) public{

        isWhitelisted[msg.sender] = true;
        lpAddress = lp;
        owner = msg.sender;
        startTime = getTime(block.timestamp);
        isInitialized = true;

        // need set address here
        usdtAddress = uAddr;
        freeAddress = free;
        fptAddress = address(0);
        lpAddress = lp;
        poolAddress = address(0);
        exchagneSwap = address(0);
        daoAddress = address(0);
    }

    modifier onlyOwner(){
        require(owner == msg.sender,"not owner");
        _;
    }

    function checkAllDefine() internal view {
        require(fptAddress != address(0),"please init fptAddress");
        require(poolAddress != address(0),"please init poolAddress");
        require(exchagneSwap != address(0), "please init exchangeSwap");
        require(daoAddress != address(0), "please init daoAddress");
    }

    
    function getTime(uint time) public view returns(uint){
        uint t = time.div(stepTime).mul(stepTime);
        return t;
    }

    function modifyReleaseFeeRate(uint rate) public onlyOwner {
        require(rate <= 100,"out of range");
        releaseRate = rate;
    }

    /**
    *  stake lp, _type 1  lock 100 days, 2 lock 100 days and every day release 1%, 3 current stake, 4 lock 180 days 
    */
    function stakeLp(uint amount, uint _type) public {
        require(amount >= 0.1 ether ,"nozero");
        require(_type>0 && _type <=4,"invalid pledge type");
        checkAllDefine();
        bytes32 id = keccak256(abi.encodePacked(msg.sender,"2",amount,block.timestamp));
        // users[msg.sender].allKey.push(id);
        require(orderCheck[id]==false,"order already exists");
        orderCheck[id] = true;
        users[msg.sender].allKey.push(id);
        IBEP20(lpAddress).transferFrom(msg.sender, address(this), amount);

        users[msg.sender].informations[id].lockAmount =  amount;
        users[msg.sender].informations[id].latestReleasedTime = block.timestamp + stepTime;
        if (_type == 4){
            users[msg.sender].informations[id].totalReleaseDay = lockTime2;
        }else{
            users[msg.sender].informations[id].totalReleaseDay = lockTime;
        }
        
        users[msg.sender].informations[id].status = 1;

        users[msg.sender].lpAmount = users[msg.sender].lpAmount.add(amount);
        users[msg.sender].informations[id]._type = _type;
        users[msg.sender].informations[id].pledge_type = 2;
        users[msg.sender].allKey.push(id);
        
        emit Pledged(msg.sender, id, _type,  amount, block.timestamp,2);

    }


    /**
    *  @dev stake with usdt,  it will burn fpt , and exchange free out , use free + usdt add liquidty the swap pool.
    *  exchange rate 100 : 1
    *  amount input amout is the number of fpt, 
    *  _type it for stake type
    */
    function stakeWithUSD(uint amount,  uint _type,uint minA, uint minB) public {
        require(amount >= 1 ether ,"not reach minimum amount");
        require(_type>0 && _type <=2,"invalid pledge type");
        checkAllDefine();

        (uint reserve0, uint reserve1, ) = IPancakePair(lpAddress).getReserves();
        require(reserve0 > 0 && reserve1 > 0,"error lp");
        uint uAmount = 0;
        uint freeAmount = amount.div(100);
        if (IPancakePair(lpAddress).token0()==usdtAddress){
            uAmount = freeAmount.mul(reserve0).div(reserve1);
        }else{
            uAmount = freeAmount.mul(reserve1).div(reserve0);
        }
        
        if (stakeFeeRate>0){
            uint fee = freeAmount.mul(stakeFeeRate).div(1000);
            IBEP20(freeAddress).transferFrom(msg.sender, daoAddress, fee);
        }

        (uint amountA, uint amountB) = IExchangeSwap(exchagneSwap).liquidityCalculator(freeAddress,usdtAddress,freeAmount,uAmount,minA,minB);

        IBEP20(fptAddress).transferFrom(msg.sender, address(1), amountA.mul(100));  // transfer fpt to address(1)
        IBEP20(freeAddress).transferFrom(poolAddress, address(this), amountA); //transfer free in
        IBEP20(usdtAddress).transferFrom(msg.sender, address(this), amountB); // transfer usdt in 


        IBEP20(freeAddress).approve(exchagneSwap, amountA);
        IBEP20(usdtAddress).approve(exchagneSwap, amountB);
        (,, uint liquidity) = IExchangeSwap(exchagneSwap).addLiquidity(freeAddress,usdtAddress,amountA,amountB,minA,minB, address(this), block.timestamp.add(3600));

        
        // IERC20(lpAddress).transfer(address(this), liquidity);
        
        bytes32 id = keccak256(abi.encodePacked(msg.sender,"1",liquidity,block.timestamp));
        require(orderCheck[id]==false,"order already exists");
        orderCheck[id] = true;
        users[msg.sender].allKey.push(id);
        users[msg.sender].informations[id].lockAmount =  liquidity;
        users[msg.sender].informations[id].latestReleasedTime = block.timestamp + stepTime;
        users[msg.sender].informations[id].totalReleaseDay = lockTime;
        users[msg.sender].informations[id].status = 1;
        users[msg.sender].informations[id]._type = _type;
        users[msg.sender].informations[id].pledge_type = 1;

        users[msg.sender].lpAmount = users[msg.sender].lpAmount.add(liquidity);

        emit Pledged(msg.sender, id, _type,  liquidity, block.timestamp,1);
        
    }

    /**
     * get UserReleaseInforamtion
     */
    function checkUserRelease(address addr, bytes32  _id)public view returns(bool, uint){
        if (users[addr].informations[_id].status != 1){
            return (false, 0);
        }
        uint _type = users[addr].informations[_id]._type;
        if (_type == 3){   //  current pledge
            return (true, users[addr].informations[_id].lockAmount.sub(users[addr].informations[_id].releasedAmount));
        }

        if(_type == 1){
            if (block.timestamp > users[addr].informations[_id].latestReleasedTime && getTime(block.timestamp).sub(getTime(users[addr].informations[_id].latestReleasedTime)).div(stepTime)>=lockTime){
                return (true, users[addr].informations[_id].lockAmount.sub(users[addr].informations[_id].releasedAmount)); 
            }
            return (false, 0);
        }
        if(_type == 2)
        {
            if (block.timestamp > users[addr].informations[_id].latestReleasedTime ){
                uint ds = getTime(block.timestamp).sub(getTime(users[addr].informations[_id].latestReleasedTime)).div(stepTime);
                if (ds >= users[addr].informations[_id].totalReleaseDay){
                    ds =  users[addr].informations[_id].totalReleaseDay;
                }
                return (true, users[addr].informations[_id].lockAmount.mul(ds).div(lockTime)); 
                    
            }
            return (false, 0);
        }

        if(_type == 4){
            if (block.timestamp > users[addr].informations[_id].latestReleasedTime && getTime(block.timestamp).sub(getTime(users[addr].informations[_id].latestReleasedTime)).div(stepTime)>=lockTime2){
                return (true, users[addr].informations[_id].lockAmount.sub(users[addr].informations[_id].releasedAmount)); 
            }
            return (false, 0);
        }
    }

    /**
    * restake lp, will not charge 10% withdraw fee;
    */
    function reStake(bytes32 _id) public {
        require(users[msg.sender].informations[_id].status == 1,"pledge has been finished");
        require(users[msg.sender].informations[_id]._type == 1, "invalid type");
        require(users[msg.sender].informations[_id].pledge_type == 1, "invalid pledge_type");
        require(block.timestamp > users[msg.sender].informations[_id].latestReleasedTime && getTime(block.timestamp).sub(getTime(users[msg.sender].informations[_id].latestReleasedTime)).div(stepTime)>=lockTime,"pledge doesn't reach the time");
        users[msg.sender].informations[_id].status = 2;
        LockInformation memory info = users[msg.sender].informations[_id];
        bytes32 newID = keccak256(abi.encodePacked(msg.sender,"3",info.lockAmount,block.timestamp));
        users[msg.sender].allKey.push(newID);
        users[msg.sender].informations[newID].lockAmount =  info.lockAmount;
        users[msg.sender].informations[newID].latestReleasedTime = block.timestamp + stepTime;
        users[msg.sender].informations[newID].totalReleaseDay = lockTime;
        users[msg.sender].informations[newID].status = 1;
        users[msg.sender].informations[newID]._type = 2;
        users[msg.sender].informations[newID].pledge_type = 2;  // not burn for get reward
        emit PledgeChanged(msg.sender, _id, newID, block.timestamp);
 
        emit Pledged(msg.sender, newID, 2,  info.lockAmount, block.timestamp, 2);

    }

    /*
    * get release for no locked pledge
    */
    function currentWithdrawal(bytes32 _id, uint amount) public returns (bool){
        require(amount > 0 ,"nozero");
        require(users[msg.sender].informations[_id].status == 1, "pledge has been finished");
        require(users[msg.sender].informations[_id]._type == 3, "not current pledge");
        require(users[msg.sender].informations[_id].lockAmount.sub(users[msg.sender].informations[_id].releasedAmount)>=amount);
        users[msg.sender].informations[_id].releasedAmount = users[msg.sender].informations[_id].releasedAmount.add(amount);
        IBEP20(lpAddress).transfer(msg.sender, amount);
        emit Released(msg.sender, _id, amount, block.timestamp); 
        if (users[msg.sender].informations[_id].releasedAmount == users[msg.sender].informations[_id].lockAmount){
            users[msg.sender].informations[_id].status = 2;
            emit PledgeFinished(msg.sender, _id, block.timestamp);
        }
        users[msg.sender].lpAmount = users[msg.sender].lpAmount.sub(amount);
    }

    /**
     * get release
     */ 
    function withdraw(bytes32 [] memory ids, uint minA, uint minB) public returns(uint,uint){
        uint len = ids.length;
        uint totalCanRelease = 0;
        uint totalCanReleaseNoFee = 0;
        for (uint i = 0 ;i < len ;i++){
            bytes32 _id = ids[i];
            if(users[msg.sender].informations[ids[i]]._type == 3){
                continue;
            }
            if(users[msg.sender].informations[ids[i]].status !=1){
                continue;
            }
            if (users[msg.sender].informations[ids[i]].status == 1){
                uint a = users[msg.sender].informations[ids[i]].lockAmount;
                uint releaseTime = users[msg.sender].informations[ids[i]].latestReleasedTime;
                uint releaseAmount = users[msg.sender].informations[ids[i]].releasedAmount;
                uint releaseTotalDay = users[msg.sender].informations[ids[i]].totalReleaseDay;
                if (users[msg.sender].informations[ids[i]]._type == 1 && block.timestamp > releaseTime && getTime(block.timestamp).sub(getTime(releaseTime)).div(stepTime)>=lockTime){
                    if (users[msg.sender].informations[ids[i]].pledge_type == 1){
                        totalCanRelease = totalCanRelease.add(a);
                    }else {
                        totalCanReleaseNoFee = totalCanReleaseNoFee.add(a);
                    }
                    users[msg.sender].informations[_id].releasedAmount = releaseAmount.add(a);
                    users[msg.sender].informations[_id].latestReleasedTime = block.timestamp;
                    users[msg.sender].informations[_id].status = 2;
                    emit Released(msg.sender, ids[i], a, block.timestamp);
                    emit PledgeFinished(msg.sender, ids[i], block.timestamp);
                }else if(users[msg.sender].informations[ids[i]]._type == 2 ){
                    uint d = getTime(block.timestamp).sub(getTime(releaseTime)).div(stepTime);
                    if ( d > 0){
                        if (d >= users[msg.sender].informations[_id].totalReleaseDay){
                            d =  users[msg.sender].informations[_id].totalReleaseDay;
                            users[msg.sender].informations[_id].status = 2;
                        }
                    }
                    users[msg.sender].informations[_id].totalReleaseDay = releaseTotalDay.sub(d);
                    uint b = a.mul(d).div(lockTime);
                    users[msg.sender].informations[_id].releasedAmount = releaseAmount.add(b);
                    if (users[msg.sender].informations[_id].pledge_type == 1){
                        totalCanRelease = totalCanRelease.add(b);
                    }else{
                        totalCanReleaseNoFee = totalCanReleaseNoFee.add(b);
                    }
                    users[msg.sender].informations[_id].latestReleasedTime = block.timestamp;
                    emit Released(msg.sender, _id, b, block.timestamp);
                    if(users[msg.sender].informations[_id].releasedAmount==a){
                        users[msg.sender].informations[_id].status = 2;
                        emit PledgeFinished(msg.sender, ids[i], block.timestamp);
                    }
                }else if (users[msg.sender].informations[ids[i]]._type == 4 && block.timestamp > releaseTime && getTime(block.timestamp).sub(getTime(releaseTime)).div(stepTime)>=lockTime2){
                    totalCanReleaseNoFee = totalCanReleaseNoFee.add(a);
                    users[msg.sender].informations[_id].releasedAmount = users[msg.sender].informations[_id].releasedAmount.add(a);
                    users[msg.sender].informations[_id].latestReleasedTime = block.timestamp;
                    users[msg.sender].informations[_id].status = 2;
                    emit Released(msg.sender, ids[i], a, block.timestamp);
                    emit PledgeFinished(msg.sender, ids[i], block.timestamp);
                }
            }
        }
        require(totalCanRelease > 0 || totalCanReleaseNoFee >0, "nothing can withdraw");

        users[msg.sender].lpAmount = users[msg.sender].lpAmount.sub(totalCanRelease).sub(totalCanReleaseNoFee);

        // release with fee charge, need remove liquidty
        if (totalCanRelease>0){
            IBEP20(lpAddress).approve(exchagneSwap,totalCanRelease);
            (uint a, uint b) = IExchangeSwap(exchagneSwap).removeLiquidity(usdtAddress, freeAddress, totalCanRelease, minA, minB, address(this), block.timestamp.add(100));

            //*****************************************/
            //calculate fee
            uint aFee = a.mul(releaseRate).div(1000);
            uint bFee = b.mul(releaseRate).div(1000);
            // transfer fee to dao address
            IBEP20(usdtAddress).transfer(daoAddress, aFee);
            IBEP20(freeAddress).transfer(daoAddress, bFee);
            /******************************************/
            // transfer to user
            IBEP20(usdtAddress).transfer(msg.sender, a.sub(aFee));
            IBEP20(freeAddress).transfer(msg.sender, b.sub(bFee));
        }
        // release with no fee, transfer direct to user
        IBEP20(lpAddress).transfer(msg.sender, totalCanReleaseNoFee);

        return (totalCanRelease, totalCanReleaseNoFee);
    }

    function getInforamtions(address addr, bytes32 id) public view returns(LockInformation memory){
        return users[addr].informations[id];
    }

    function getUserKeys(address addr) public view returns(bytes32[]memory ){
        return users[addr].allKey;
    }

}