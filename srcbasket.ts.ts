import { Rebalanced, Deposited, Withdrawn } from "../generated/Basket/Basket"
import { Rebalance, Deposit, Withdrawal } from "../generated/schema"
import { BigInt } from "@graphprotocol/graph-ts"

export function handleRebalanced(event: Rebalanced): void {
  let entity = new Rebalance(event.transaction.hash.toHex())
  entity.caller = event.params.caller
  entity.amounts = event.params.newAmounts
  entity.timestamp = event.block.timestamp
  entity.blockNumber = event.block.number
  entity.save()
}

export function handleDeposited(event: Deposited): void {
  let entity = new Deposit(event.transaction.hash.toHex())
  entity.user = event.params.user
  entity.amountIn = event.params.amountIn
  entity.amountsOut = event.params.amountsOut
  entity.timestamp = event.block.timestamp
  entity.blockNumber = event.block.number
  entity.save()
}

export function handleWithdrawn(event: Withdrawn): void {
  let entity = new Withdrawal(event.transaction.hash.toHex())
  entity.user = event.params.user
  entity.amountOut = event.params.amountOut
  entity.amountsIn = event.params.amountsIn
  entity.timestamp = event.block.timestamp
  entity.blockNumber = event.block.number
  entity.save()
}